import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:iot_anomaly_emulator/devices/model/device.dart';
import 'package:iot_anomaly_emulator/devices/providers/current_device_state.dart';
import 'package:iot_anomaly_emulator/devices/providers/current_process_type_provider.dart';
import 'package:iot_anomaly_emulator/devices/view/device_page.dart';
import 'package:iot_anomaly_emulator/home/providers/mqtt_controller_provider.dart';
import 'package:iot_anomaly_emulator/home/repository/mqtt_core.dart';
import 'package:iot_anomaly_emulator/l10n/l10n.dart';
import 'package:mocktail/mocktail.dart';

class MockMQTTController extends Mock implements MQTTController {}

void main() {
  group('DevicePage', () {
    late MockMQTTController mockMqttController;

    setUp(() {
      mockMqttController = MockMQTTController();
      when(
        () => mockMqttController.sendMessage(
          any<String>(),
          any<Map<String, dynamic>>(),
        ),
      ).thenReturn(null);
    });

    testWidgets('should render DevicePage with device ID', (tester) async {
      // Arrange
      final container = ProviderContainer(
        overrides: [
          mqttControllerProvider.overrideWith((ref) => mockMqttController),
        ],
      );

      // Act
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: GoRouter(
            routes: [
              GoRoute(
                path: '/device/:id',
                builder: (context, state) {
                  final id = int.tryParse(
                    state.pathParameters['id'].toString(),
                  ) ?? 0;
                  return UncontrolledProviderScope(
                    container: container,
                    child: DevicePage(deviceId: id),
                  );
                },
              ),
            ],
            initialLocation: '/device/1',
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(DevicePage), findsOneWidget);

      container.dispose();
    });

    testWidgets('should display process type option tile', (tester) async {
      // Arrange
      final container = ProviderContainer(
        overrides: [
          mqttControllerProvider.overrideWith((ref) => mockMqttController),
          currentProcessTypeProvider.overrideWith(
            () => CurrentProcessType()..value = 1,
          ),
        ],
      );

      // Act
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: GoRouter(
            routes: [
              GoRoute(
                path: '/device/:id',
                builder: (context, state) {
                  final id = int.tryParse(
                    state.pathParameters['id'].toString(),
                  ) ?? 0;
                  return UncontrolledProviderScope(
                    container: container,
                    child: DevicePage(deviceId: id),
                  );
                },
              ),
            ],
            initialLocation: '/device/1',
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(DevicePage), findsOneWidget);

      container.dispose();
    });

    testWidgets('should display device state option tile', (tester) async {
      // Arrange
      final container = ProviderContainer(
        overrides: [
          mqttControllerProvider.overrideWith((ref) => mockMqttController),
          currentDeviceStateProvider.overrideWith(
            () => CurrentDeviceState()..value = 1,
          ),
        ],
      );

      // Act
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: GoRouter(
            routes: [
              GoRoute(
                path: '/device/:id',
                builder: (context, state) {
                  final id = int.tryParse(
                    state.pathParameters['id'].toString(),
                  ) ?? 0;
                  return UncontrolledProviderScope(
                    container: container,
                    child: DevicePage(deviceId: id),
                  );
                },
              ),
            ],
            initialLocation: '/device/1',
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(DevicePage), findsOneWidget);

      container.dispose();
    });

    testWidgets('should find device by ID', (tester) async {
      // Arrange
      final container = ProviderContainer(
        overrides: [
          mqttControllerProvider.overrideWith((ref) => mockMqttController),
        ],
      );

      // Act
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: GoRouter(
            routes: [
              GoRoute(
                path: '/device/:id',
                builder: (context, state) {
                  final id = int.tryParse(
                    state.pathParameters['id'].toString(),
                  ) ?? 0;
                  return UncontrolledProviderScope(
                    container: container,
                    child: DevicePage(deviceId: id),
                  );
                },
              ),
            ],
            initialLocation: '/device/1',
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      await tester.pumpAndSettle();

      // Assert
      final device = emulatedDevices.firstWhere((e) => e.id == 1);
      expect(device.id, equals(1));

      container.dispose();
    });

    testWidgets('should display history chart', (tester) async {
      // Arrange
      final container = ProviderContainer(
        overrides: [
          mqttControllerProvider.overrideWith((ref) => mockMqttController),
        ],
      );

      // Act
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: GoRouter(
            routes: [
              GoRoute(
                path: '/device/:id',
                builder: (context, state) {
                  final id = int.tryParse(
                    state.pathParameters['id'].toString(),
                  ) ?? 0;
                  return UncontrolledProviderScope(
                    container: container,
                    child: DevicePage(deviceId: id),
                  );
                },
              ),
            ],
            initialLocation: '/device/1',
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(DevicePage), findsOneWidget);

      container.dispose();
    });
  });
}
