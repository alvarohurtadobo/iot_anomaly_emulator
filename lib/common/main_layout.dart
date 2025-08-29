import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iot_anomaly_emulator/common/view/drawer.dart';
import 'package:iot_anomaly_emulator/l10n/l10n.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 800;
    final l10n = context.l10n;

    if (isLargeScreen) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              extended: true,
              destinations: [
                NavigationRailDestination(
                  icon: const Icon(Icons.home),
                  label: Text(l10n.home),
                ),
                const NavigationRailDestination(
                  icon: Icon(Icons.hardware),
                  label: Text('Devices'),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.settings),
                  label: Text(l10n.settings),
                ),
                const NavigationRailDestination(
                  icon: const Icon(Icons.logout),
                  label: Text('Logout'),
                ),
              ],
              selectedIndex: _getSelectedIndex(context),
              onDestinationSelected: (index) {
                switch (index) {
                  case 0:
                    context.go('/');
                  case 1:
                    context.go('/devices');
                  case 2:
                    context.go('/settings');
                  case 5:
                    context.go('/');
                }
              },
            ),
            Expanded(child: child),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('App')),
      drawer: myDrawer(context),
      body: child,
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/settings')) return 1;
    return 0;
  }
}
