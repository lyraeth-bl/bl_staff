import 'package:bl_staff/core/app_router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex(context),
        onDestinationSelected: (index) => _onTabTapped(context, index),
        destinations: <Widget>[
          NavigationDestination(icon: Icon(LucideIcons.house), label: "Home"),
          NavigationDestination(
            icon: Icon(LucideIcons.calendarDays),
            label: "Attendance",
          ),
          NavigationDestination(icon: Icon(LucideIcons.user), label: "Profile"),
        ],
      ),
    );
  }

  int _selectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    if (location.startsWith(RouteNames.dashboard)) return 0;
    if (location.startsWith(RouteNames.attendance)) return 1;
    if (location.startsWith(RouteNames.profile)) return 2;

    return 0;
  }

  void _onTabTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(RouteNames.dashboard);
      case 1:
        context.go(RouteNames.attendance);
      case 2:
        context.go(RouteNames.profile);
    }
  }
}
