import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/data/datasources/preferences_helper.dart';
import 'package:nutrizham/presentation/blocs/settings_cubit.dart';
import 'package:nutrizham/presentation/pages/authentication/Onboard_Page/welcome_page.dart';
import 'package:nutrizham/presentation/pages/authentication/login_page.dart';
import 'package:nutrizham/presentation/pages/authentication/register_page.dart';
import 'package:nutrizham/presentation/pages/layout/main_navigation.dart';
import 'package:nutrizham/presentation/pages/layout/Home_page/home_page.dart';
import 'package:nutrizham/presentation/pages/layout/Search_page/search_page.dart';
import 'package:nutrizham/presentation/pages/layout/Planner_page/planner_page.dart';
import 'package:nutrizham/presentation/pages/layout/Profile_page/profile_page.dart';
import 'package:nutrizham/presentation/pages/layout/Details_page/details_screen.dart';
import 'package:nutrizham/presentation/pages/layout/Profile_page/settings_page/settings_page.dart';
import 'package:nutrizham/presentation/pages/layout/Profile_page/features_page/app_features_page.dart';
import 'package:nutrizham/presentation/pages/layout/Profile_page/Edit_account_page/edit_account_page.dart';
import 'package:nutrizham/presentation/pages/layout/Profile_page/Edit_account_page/Change_Password_Page/change_password_page.dart';

GoRouter buildRouter() {
  return GoRouter(
    initialLocation: '/welcome',
    redirect: (context, state) async {
      final settings = context.read<SettingsCubit>().state;
      final isLoggedIn = settings.isLoggedIn;
      final currentPath = state.matchedLocation;

      final isAuthRoute = currentPath == '/welcome' ||
          currentPath == '/login' ||
          currentPath == '/register';

      if (!isLoggedIn && !isAuthRoute) {
        return '/login';
      }

      if (isLoggedIn && isAuthRoute) {
        return '/home';
      }

      if (!isLoggedIn && currentPath == '/welcome' &&
          await PreferencesHelper.hasWelcomeBeenShown()) {
        return '/login';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainNavigation(child: child),
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomePage(),
            ),
          ),
          GoRoute(
            path: '/search',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SearchPage(),
            ),
          ),
          GoRoute(
            path: '/planner',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: PlannerPage(),
            ),
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProfilePage(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/recipe/:id',
        builder: (context, state) {
          final recipe = state.extra as Recipe;
          return RecipeDetailScreen(recipe: recipe);
        },
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: '/settings/change-password',
        builder: (context, state) => const ChangePasswordPage(),
      ),
      GoRoute(
        path: '/settings/edit-account',
        builder: (context, state) => const EditAccountPage(),
      ),
      GoRoute(
        path: '/features',
        builder: (context, state) => const AppFeaturesPage(),
      ),
    ],
  );
}
