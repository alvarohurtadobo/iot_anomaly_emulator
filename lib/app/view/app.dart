import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' show GoRoute, GoRouter;
import 'package:iot_anomaly_emulator/home/counter.dart';
import 'package:iot_anomaly_emulator/home/repository/mqtt_core.dart';
import 'package:iot_anomaly_emulator/l10n/l10n.dart';
import 'package:iot_anomaly_emulator/settings/view/settings.dart';

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/details/:id',
      builder: (context, state) {
        // final id = state.params['id']!;
        return const SettingsPage();
      },
    ),
  ],
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final myMqttController = MQTTConttoller()..init();

    return MaterialApp.router(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _router,
    );
  }
}
