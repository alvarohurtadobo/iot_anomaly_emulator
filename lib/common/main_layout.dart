import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iot_anomaly_emulator/common/view/drawer.dart';
import 'package:iot_anomaly_emulator/l10n/l10n.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.sizeOf(context).width > 800;
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
                NavigationRailDestination(
                  icon: const Icon(Icons.hardware),
                  label: Text(l10n.devices),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.settings),
                  label: Text(l10n.settings),
                ),
                // const NavigationRailDestination(
                //   icon: Icon(Icons.logout),
                //   label: Text('Logout'),
                // ),
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
      appBar: AppBar(title: Text(_getSelectedTitle(context))),
      drawer: myDrawer(context),
      body: child,
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/devices')) return 1;
    if (location.startsWith('/settings')) return 2;
    return 0;
  }

  String _getSelectedTitle(BuildContext context) {
    final l10n = context.l10n;
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/devices')) return l10n.devices;
    if (location.startsWith('/device')) return l10n.device;
    if (location.startsWith('/settings')) return l10n.setting;
    return l10n.home;
  }
}
