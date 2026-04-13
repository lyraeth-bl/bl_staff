import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: navigationShell,

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: colorScheme.outlineVariant, width: 1),
          ),
        ),
        child: NavigationBar(
          backgroundColor: colorScheme.surface,
          elevation: 0,
          indicatorColor: colorScheme.primaryContainer,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: (index) => _onTabTapped(index),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: [
            NavigationDestination(
              icon: Icon(
                LucideIcons.house,
                color: colorScheme.onSurfaceVariant,
              ),
              selectedIcon: Icon(
                LucideIcons.house,
                color: colorScheme.onPrimaryContainer,
              ),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(
                LucideIcons.calendarDays,
                color: colorScheme.onSurfaceVariant,
              ),
              selectedIcon: Icon(
                LucideIcons.calendarDays,
                color: colorScheme.onPrimaryContainer,
              ),
              label: "Attendance",
            ),
            NavigationDestination(
              icon: Icon(LucideIcons.user, color: colorScheme.onSurfaceVariant),
              selectedIcon: Icon(
                LucideIcons.user,
                color: colorScheme.onPrimaryContainer,
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }

  void _onTabTapped(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
