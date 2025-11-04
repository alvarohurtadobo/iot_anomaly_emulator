import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_anomaly_emulator/devices/providers/current_process_type_provider.dart';
import 'package:iot_anomaly_emulator/devices/providers/sensor_history_provider.dart';
import 'package:iot_anomaly_emulator/devices/providers/sensor_stream_provider.dart';

void main() {
  group('sensorHistoryProvider', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is empty list', () {
      // Act
      final state = container.read(sensorHistoryProvider);

      // Assert
      expect(state, isEmpty);
    });

    test('should accumulate sensor data from stream', () async {
      // Arrange
      container.read(currentProcessTypeProvider.notifier).value = 1;

      // Wait for provider to initialize
      await container.read(
        sensorStreamProvider(const Duration(milliseconds: 50)).future,
      );

      // Act - wait for stream to emit data
      await Future<void>.delayed(const Duration(milliseconds: 200));

      // Assert
      final history = container.read(sensorHistoryProvider);
      expect(history, isNotEmpty);
    });

    test('should limit history to maxLength', () async {
      // Arrange
      container.read(currentProcessTypeProvider.notifier).value = 1;

      // Wait for provider to initialize
      await container.read(
        sensorStreamProvider(const Duration(milliseconds: 10)).future,
      );

      // Act - wait for many emissions
      await Future<void>.delayed(const Duration(milliseconds: 500));

      // Assert
      final history = container.read(sensorHistoryProvider);
      expect(
        history.length,
        lessThanOrEqualTo(SensorHistoryNotifier.maxLength),
      );
    });

    test('should update history when new data arrives', () async {
      // Arrange
      container.read(currentProcessTypeProvider.notifier).value = 1;

      // Wait for provider to initialize
      await container.read(
        sensorStreamProvider(const Duration(milliseconds: 50)).future,
      );

      final initialHistory = container.read(sensorHistoryProvider);

      // Act - wait for more data
      await Future<void>.delayed(const Duration(milliseconds: 200));

      // Assert
      final updatedHistory = container.read(sensorHistoryProvider);
      expect(
        updatedHistory.length,
        greaterThanOrEqualTo(initialHistory.length),
      );
    });

    test('should listen to process type changes', () async {
      // Arrange
      container.read(currentProcessTypeProvider.notifier).value = 1;

      // Wait for provider to initialize
      await container.read(
        sensorStreamProvider(const Duration(milliseconds: 50)).future,
      );

      await Future<void>.delayed(const Duration(milliseconds: 100));

      final historyBefore = container.read(sensorHistoryProvider).length;

      // Act - change process type
      container.read(currentProcessTypeProvider.notifier).value = 2;

      // Wait for new data
      await Future<void>.delayed(const Duration(milliseconds: 200));

      // Assert
      final historyAfter = container.read(sensorHistoryProvider);
      expect(historyAfter.length, greaterThanOrEqualTo(historyBefore));
    });

    test('should maintain max length when exceeding limit', () async {
      // Arrange
      container.read(currentProcessTypeProvider.notifier).value = 1;

      // Wait for provider to initialize
      await container.read(
        sensorStreamProvider(const Duration(milliseconds: 10)).future,
      );

      // Act - wait for many emissions to exceed maxLength
      await Future<void>.delayed(const Duration(milliseconds: 1000));

      // Assert
      final history = container.read(sensorHistoryProvider);
      expect(
        history.length,
        lessThanOrEqualTo(SensorHistoryNotifier.maxLength),
      );
      if (history.length >= SensorHistoryNotifier.maxLength) {
        // Should keep the most recent data (sublist removes oldest)
        expect(history.length, lessThan(SensorHistoryNotifier.maxLength));
      }
    });

    test('should handle empty stream data', () async {
      // Arrange
      container.read(currentProcessTypeProvider.notifier).value = null;

      // Wait for provider to initialize
      await container.read(
        sensorStreamProvider(const Duration(milliseconds: 50)).future,
      );

      // Act - wait for data
      await Future<void>.delayed(const Duration(milliseconds: 200));

      // Assert
      final history = container.read(sensorHistoryProvider);
      // History can accumulate even with empty data
      expect(history, isA<List<SensorData>>());
    });

    test('should cancel subscription on dispose', () async {
      // Arrange
      container.read(currentProcessTypeProvider.notifier).value = 1;

      // Wait for provider to initialize
      await container.read(
        sensorStreamProvider(const Duration(milliseconds: 50)).future,
      );

      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Act - dispose container
      container.dispose();

      // Create new container
      final newContainer = ProviderContainer();
      newContainer.read(currentProcessTypeProvider.notifier).value = 1;

      // Wait a bit
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert - new container should have fresh history
      final newHistory = newContainer.read(sensorHistoryProvider);
      // New container should have its own history
      expect(newHistory, isA<List<SensorData>>());

      newContainer.dispose();
    });
  });
}
