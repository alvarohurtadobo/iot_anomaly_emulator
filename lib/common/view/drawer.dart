import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iot_anomaly_emulator/l10n/l10n.dart';

Drawer myDrawer(BuildContext context) {
  final l10n = context.l10n;
  final location = GoRouterState.of(context).uri.toString();
  print('Rebuild with location $location');
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'IoT Monitor',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: Text(l10n.home),
          onTap: () {
            context
              ..go('/')
              ..pop();
          },
        ),
        ListTile(
          leading: const Icon(Icons.hardware),
          title: Text(l10n.devices),
          onTap: () => context
            ..go('/devices')
            ..pop(),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: Text(l10n.settings),
          onTap: () {
            context
              ..go('/settings')
              ..pop();
          },
        ),
        // ListTile(
        //   leading: const Icon(Icons.logout),
        //   title: const Text('Logout'),
        //   onTap: () {
        //     context..go('/')
        //     ..pop();
        //   },
        // ),
      ],
    ),
  );
}
