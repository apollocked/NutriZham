import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrizham/l10n/app_localizations.dart';
import 'package:nutrizham/presentation/widgets/common/nav_item.dart';
import 'package:nutrizham/presentation/widgets/common/offline_banner.dart';
import 'package:nutrizham/presentation/widgets/common/animated_bottom_nav.dart';

class MainNavigation extends StatelessWidget {
  final Widget child;

  const MainNavigation({super.key, required this.child});

  void _onDestinationSelected(BuildContext context, int index) {
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
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final currentLocation = GoRouterState.of(context).matchedLocation;
    int currentIndex = 0;
    if (currentLocation.startsWith('/search')) currentIndex = 1;
    if (currentLocation.startsWith('/planner')) currentIndex = 2;
    if (currentLocation.startsWith('/profile')) currentIndex = 3;

    final isWide = MediaQuery.sizeOf(context).width >= 600;

    final destinations = [
      NavigationRailDestination(
        icon: const Icon(Icons.home_outlined),
        selectedIcon: const Icon(Icons.home_rounded),
        label: Text(loc.home),
      ),
      NavigationRailDestination(
        icon: const Icon(Icons.search_outlined),
        selectedIcon: const Icon(Icons.search_rounded),
        label: Text(loc.search),
      ),
      NavigationRailDestination(
        icon: const Icon(Icons.calendar_today_outlined),
        selectedIcon: const Icon(Icons.calendar_month_rounded),
        label: Text(loc.planner),
      ),
      NavigationRailDestination(
        icon: const Icon(Icons.person_outline),
        selectedIcon: const Icon(Icons.person_rounded),
        label: Text(loc.profile),
      ),
    ];

    final bottomNavItems = [
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
    ];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(loc.exitAppTitle),
            content: Text(loc.exitApp),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(loc.cancel),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(loc.exit),
              ),
            ],
          ),
        );
        if (confirmed == true && context.mounted) {
          SystemNavigator.pop();
        }
      },
      child: isWide
          ? Scaffold(
              body: Row(
                children: [
                  SafeArea(
                    right: false,
                    child: NavigationRail(
                      selectedIndex: currentIndex,
                      onDestinationSelected: (index) =>
                          _onDestinationSelected(context, index),
                      labelType: NavigationRailLabelType.all,
                      minWidth: 80,
                      groupAlignment: -0.9,
                      leading: const SizedBox(height: 8),
                      destinations: destinations,
                    ),
                  ),
                  const VerticalDivider(width: 1, thickness: 1),
                  Expanded(
                    child: Column(
                      children: [
                        const OfflineBanner(),
                        Expanded(child: child),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Scaffold(
              extendBody: true,
              body: Column(
                children: [
                  const OfflineBanner(),
                  Expanded(child: child),
                ],
              ),
              bottomNavigationBar: SafeArea(
                top: false,
                child: AnimatedBottomNav(
                  selectedIndex: currentIndex,
                  onDestinationSelected: (index) =>
                      _onDestinationSelected(context, index),
                  items: bottomNavItems,
                ),
              ),
            ),
    );
  }
}
