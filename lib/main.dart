import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nutrizham/core/cache/cache_service.dart';
import 'package:nutrizham/core/themes/app_theme.dart';
import 'package:nutrizham/core/utils/locale_helpers.dart';
import 'package:nutrizham/l10n/app_localizations.dart';
import 'package:nutrizham/presentation/blocs/settings_cubit.dart';
import 'package:nutrizham/presentation/blocs/auth_cubit.dart';
import 'package:nutrizham/presentation/blocs/favorites_cubit.dart';
import 'package:nutrizham/presentation/blocs/meal_planner_cubit.dart';
import 'package:nutrizham/presentation/blocs/recipe_cubit.dart';
import 'package:nutrizham/core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheService().init();
  final settings = SettingsCubit();
  await settings.initialize();

  runApp(NutriZhamApp(settings: settings));
}

class NutriZhamApp extends StatelessWidget {
  final SettingsCubit settings;

  const NutriZhamApp({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsCubit>.value(
      value: settings,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthCubit()),
          BlocProvider(create: (_) => FavoritesCubit()),
          BlocProvider(create: (_) => MealPlannerCubit()),
          BlocProvider(create: (_) => RecipeCubit()),
        ],
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, settingsState) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'NutriZham',
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode:
                  settingsState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              locale: Locale(settingsState.languageCode),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                KurdishSafeMaterialDelegate(),
                KurdishSafeCupertinoDelegate(),
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              routerConfig: buildRouter(),
            );
          },
        ),
      ),
    );
  }
}
