import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Drawer myDrawer(BuildContext context) {
  final location = GoRouterState.of(context).uri.toString();
  print("Rebuild with location $location");
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: const <Widget>[
        DrawerHeader(
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
          leading: Icon(Icons.home),
          title: Text('Home'),
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Logout'),
        ),
      ],
    ),
  );
}
