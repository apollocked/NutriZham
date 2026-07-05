import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrizham/l10n/app_localizations.dart';
import 'package:nutrizham/presentation/widgets/common/nav_item.dart';
import 'package:nutrizham/presentation/widgets/common/offline_banner.dart';
import 'package:nutrizham/presentation/widgets/common/animated_bottom_nav.dart';

class MainNavigation extends StatelessWidget {
  final Widget child;

  const MainNavigation({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final currentLocation = GoRouterState.of(context).matchedLocation;
    int currentIndex = 0;
    if (currentLocation.startsWith('/search')) currentIndex = 1;
    if (currentLocation.startsWith('/planner')) currentIndex = 2;
    if (currentLocation.startsWith('/profile')) currentIndex = 3;

    return Scaffold(
      body: Column(
        children: [
          const OfflineBanner(),
          Expanded(child: child),
        ],
      ),
      bottomNavigationBar: AnimatedBottomNav(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              context.go('/home');
            case 1:
              context.go('/search');
            case 2:
              context.go('/planner');
            case 3:
              context.go('/profile');
          }
        },
        items: [
          AnimatedNavItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home_rounded,
            label: loc.home,
          ),
          AnimatedNavItem(
            icon: Icons.search_outlined,
            activeIcon: Icons.search_rounded,
            label: loc.search,
          ),
          AnimatedNavItem(
            icon: Icons.calendar_today_outlined,
            activeIcon: Icons.calendar_month_rounded,
            label: loc.planner,
          ),
          AnimatedNavItem(
            icon: Icons.person_outline,
            activeIcon: Icons.person_rounded,
            label: loc.profile,
          ),
        ],
      ),
    );
  }
}
