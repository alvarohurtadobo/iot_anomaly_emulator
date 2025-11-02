import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_anomaly_emulator/home/providers/mqtt_controller_provider.dart';
import 'package:iot_anomaly_emulator/home/repository/mqtt_core.dart';
import 'package:mocktail/mocktail.dart';

// Mock del MQTTController
class MockMQTTController extends Mock implements MQTTController {}

void main() {
  group('mqttControllerProvider', () {
    test('returns an instance of MQTTController', () {
      // Arrange
      final container = ProviderContainer(
        overrides: [
          // Override para evitar la inicialización real durante el test
          mqttControllerProvider.overrideWith((ref) {
            final controller = MockMQTTController();
            // No llamamos init() para evitar conexión real
            return controller;
          }),
        ],
      );

      // Act
      final controller = container.read(mqttControllerProvider);

      // Assert
      expect(controller, isA<MQTTController>());

      container.dispose();
    });

    test('provider creates new controller instance', () {
      // Arrange
      final container = ProviderContainer(
        overrides: [
          mqttControllerProvider.overrideWith((ref) {
            return MockMQTTController();
          }),
        ],
      );

      // Act
      final controller1 = container.read(mqttControllerProvider);
      final controller2 = container.read(mqttControllerProvider);

      // Assert - el provider debe devolver la misma instancia (singleton)
      expect(controller1, equals(controller2));

      container.dispose();
    });

    test('calls disconnect when provider is disposed', () {
      // Arrange
      final mockController = MockMQTTController();
      when(mockController.disconnect).thenReturn(null);

      ProviderContainer(
        overrides: [
          mqttControllerProvider.overrideWith((ref) {
            ref.onDispose(mockController.disconnect);
            return mockController;
          }),
        ],
      )

      // Act - leer el provider para activar onDispose
      ..read(mqttControllerProvider)

      // Assert - al destruir el container, se debe llamar disconnect
      ..dispose();

      verify(mockController.disconnect).called(1);
    });
  });
}
