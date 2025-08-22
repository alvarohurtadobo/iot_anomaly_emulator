

import 'package:go_router/go_router.dart';
import 'package:iot_anomaly_emulator/devices/view/devices_page.dart';
import 'package:iot_anomaly_emulator/home/view/home_page.dart';
import 'package:iot_anomaly_emulator/settings/view/settings.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/device/:id',
      builder: (context, state) {
        final id = state.params['id'] as int;
        return DevicePage(deviceId: id,);
      },
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);
