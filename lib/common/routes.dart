import 'package:go_router/go_router.dart';
import 'package:iot_anomaly_emulator/common/main_layout.dart';
import 'package:iot_anomaly_emulator/devices/view/device_page.dart';
import 'package:iot_anomaly_emulator/devices/view/devices_page.dart';
import 'package:iot_anomaly_emulator/home/view/home_page.dart';
import 'package:iot_anomaly_emulator/settings/view/settings.dart';

final GoRouter router = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/devices',
          builder: (context, state) => const DevicesPage(),
        ),
        GoRoute(
          path: '/device/:id',
          builder: (context, state) {
            final id = int.tryParse(state.pathParameters['id'].toString()) ?? 0;
            return DevicePage(
              deviceId: id,
            );
          },
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsPage(),
        ),
      ],
    ),
  ],
);
