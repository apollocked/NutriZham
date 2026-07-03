import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:nutrizham/presentation/providers/settings_provider.dart';
import 'package:nutrizham/pages/authentication/Onboard_Page/welcome_page.dart';
import 'package:nutrizham/pages/authentication/login_page.dart';
import 'package:nutrizham/pages/authentication/register_page.dart';
import 'package:nutrizham/pages/layout/main_navigation.dart';
import 'package:nutrizham/pages/layout/Home_page/home_page.dart';
import 'package:nutrizham/pages/layout/Search_page/search_page.dart';
import 'package:nutrizham/pages/layout/Planner_page/planner_page.dart';
import 'package:nutrizham/pages/layout/Profile_page/profile_page.dart';
import 'package:nutrizham/pages/layout/Details_page/details_screen.dart';
import 'package:nutrizham/pages/layout/Profile_page/settings_page/settings_page.dart';
import 'package:nutrizham/pages/layout/Profile_page/features_page/app_features_page.dart';
import 'package:nutrizham/pages/layout/Profile_page/Edit_account_page/edit_account_page.dart';
import 'package:nutrizham/pages/layout/Profile_page/Edit_account_page/Change_Password_Page/change_password_page.dart';
import 'package:nutrizham/utils/meals_data.dart';

GoRouter buildRouter() {
  return GoRouter(
    initialLocation: '/welcome',
    redirect: (context, state) {
      final settings = context.read<SettingsProvider>();
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
