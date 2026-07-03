import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:nutrizham/presentation/providers/settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainNavigation extends StatelessWidget {
  final Widget child;

  const MainNavigation({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final settings = context.watch<SettingsProvider>();
    final theme = Theme.of(context);

    final currentLocation = GoRouterState.of(context).matchedLocation;
    int currentIndex = 0;
    if (currentLocation.startsWith('/search')) currentIndex = 1;
    if (currentLocation.startsWith('/planner')) currentIndex = 2;
    if (currentLocation.startsWith('/profile')) currentIndex = 3;

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: settings.isDarkMode ? const Color(0xFF1A1A2E) : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
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
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                elevation: 0,
                indicatorColor: theme.colorScheme.primary.withOpacity(0.15),
                indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                height: 64,
                destinations: [
                  NavigationDestination(
                    icon: const Icon(Icons.home_outlined),
                    selectedIcon: const Icon(Icons.home, color: Color(0xFF10B981)),
                    label: loc.home,
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.search_outlined),
                    selectedIcon: const Icon(Icons.search, color: Color(0xFF10B981)),
                    label: loc.search,
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.calendar_today_outlined),
                    selectedIcon: const Icon(Icons.calendar_today, color: Color(0xFF10B981)),
                    label: loc.planner,
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.person_outline),
                    selectedIcon: const Icon(Icons.person, color: Color(0xFF10B981)),
                    label: loc.profile,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
