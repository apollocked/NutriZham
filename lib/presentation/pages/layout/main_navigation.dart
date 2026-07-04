import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class MainNavigation extends StatelessWidget {
  final Widget child;

  const MainNavigation({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final currentLocation = GoRouterState.of(context).matchedLocation;
    int currentIndex = 0;
    if (currentLocation.startsWith('/search')) currentIndex = 1;
    if (currentLocation.startsWith('/planner')) currentIndex = 2;
    if (currentLocation.startsWith('/profile')) currentIndex = 3;

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: NavigationBar(
              selectedIndex: currentIndex,
              onDestinationSelected: (index) {
                switch (index) {
                  case 0: context.go('/home');
                  case 1: context.go('/search');
                  case 2: context.go('/planner');
                  case 3: context.go('/profile');
                }
              },
              backgroundColor: theme.colorScheme.surface.withOpacity(0.75),
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              indicatorColor: theme.colorScheme.primary.withOpacity(0.15),
              indicatorShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              height: 64,
              destinations: [
                _NavDest(
                  icon: const Icon(Icons.home_outlined),
                  selectedIcon:
                      Icon(Icons.home, color: theme.colorScheme.primary),
                  label: loc.home,
                  selected: currentIndex == 0,
                ),
                _NavDest(
                  icon: const Icon(Icons.search_outlined),
                  selectedIcon:
                      Icon(Icons.search, color: theme.colorScheme.primary),
                  label: loc.search,
                  selected: currentIndex == 1,
                ),
                _NavDest(
                  icon: const Icon(Icons.calendar_today_outlined),
                  selectedIcon: Icon(Icons.calendar_today,
                      color: theme.colorScheme.primary),
                  label: loc.planner,
                  selected: currentIndex == 2,
                ),
                _NavDest(
                  icon: const Icon(Icons.person_outline),
                  selectedIcon:
                      Icon(Icons.person, color: theme.colorScheme.primary),
                  label: loc.profile,
                  selected: currentIndex == 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavDest extends StatelessWidget {
  final Widget icon;
  final Widget selectedIcon;
  final String label;
  final bool selected;

  const _NavDest({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: icon,
      selectedIcon: selectedIcon,
      label: label,
    );
  }
}
