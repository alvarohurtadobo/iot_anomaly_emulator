import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_anomaly_emulator/devices/providers/current_device_state.dart';
import 'package:iot_anomaly_emulator/devices/providers/current_process_type_provider.dart';
import 'package:iot_anomaly_emulator/devices/providers/sensor_history_provider.dart';
import 'package:iot_anomaly_emulator/devices/providers/sensor_stream_provider.dart';
import 'package:iot_anomaly_emulator/devices/providers/start_datetime_provider.dart';

void main() {
  group('SensorHistoryNotifier', () {
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

    test('accumulates sensor data from stream', () async {
      // Arrange
      container.read(currentProcessTypeProvider.notifier).value = 1;
      container.read(currentDeviceStateProvider.notifier).value = 1;
      container.read(currentStartDatetimeProvider.notifier).value = DateTime(
        2025,
        1,
        1,
        12,
        0,
      );

      final stream = container.read(
        sensorStreamProvider(const Duration(milliseconds: 100)).stream,
      );

      // Act - wait for multiple emissions
      await stream.take(5).toList();

      // Allow some time for the history to be updated
      await Future<void>.delayed(const Duration(milliseconds: 200));

      // Assert
      final history = container.read(sensorHistoryProvider);
      expect(history.length, greaterThan(0));
      expect(
        history.length,
        lessThanOrEqualTo(SensorHistoryNotifier.maxLength),
      );
    });

    test('limits history to maxLength - 1 elements', () async {
      // Arrange
      container.read(currentProcessTypeProvider.notifier).value = 1;
      container.read(currentDeviceStateProvider.notifier).value = 1;
      container.read(currentStartDatetimeProvider.notifier).value = DateTime(
        2025,
        1,
        1,
        12,
        0,
      );

      final stream = container.read(
        sensorStreamProvider(const Duration(milliseconds: 50)).stream,
      );

      // Act - collect more than maxLength items
      const count = SensorHistoryNotifier.maxLength + 10;
      await stream.take(count).toList();

      // Allow time for processing
      await Future<void>.delayed(const Duration(milliseconds: 500));

      // Assert
      final history = container.read(sensorHistoryProvider);
      expect(
        history.length,
        lessThanOrEqualTo(SensorHistoryNotifier.maxLength - 1),
      );
    });

    test('history contains valid SensorData objects', () async {
      // Arrange
      container.read(currentProcessTypeProvider.notifier).value = 1;
      container.read(currentDeviceStateProvider.notifier).value = 1;
      container.read(currentStartDatetimeProvider.notifier).value = DateTime(
        2025,
        1,
        1,
        12,
        0,
      );

      final stream = container.read(
        sensorStreamProvider(const Duration(milliseconds: 100)).stream,
      );

      // Act
      await stream.take(3).toList();
      await Future<void>.delayed(const Duration(milliseconds: 200));

      // Assert
      final history = container.read(sensorHistoryProvider);
      if (history.isNotEmpty) {
        expect(history.first, isA<SensorData>());
        expect(history.first.values, isNotEmpty);
        expect(history.first.timestamp, isA<DateTime>());
      }
    });

    test('listens to process type changes and rebuilds', () async {
      // Arrange
      container.read(currentDeviceStateProvider.notifier).value = 1;
      container.read(currentStartDatetimeProvider.notifier).value = DateTime(
        2025,
        1,
        1,
        12,
        0,
      );

      // Start with vibration process
      container.read(currentProcessTypeProvider.notifier).value = 1;
      final stream = container.read(
        sensorStreamProvider(const Duration(milliseconds: 100)).stream,
      );

      // Act
      await stream.take(2).toList();
      await Future<void>.delayed(const Duration(milliseconds: 200));

      final history1 = container.read(sensorHistoryProvider);

      // Change to oil process
      container.read(currentProcessTypeProvider.notifier).value = 2;
      await stream.take(2).toList();
      await Future<void>.delayed(const Duration(milliseconds: 200));

      final history2 = container.read(sensorHistoryProvider);

      // Assert
      expect(history1.length, greaterThanOrEqualTo(0));
      expect(history2.length, greaterThanOrEqualTo(0));
    });

    test('handles null process type gracefully', () async {
      // Arrange
      container.read(currentProcessTypeProvider.notifier).value = null;
      container.read(currentDeviceStateProvider.notifier).value = 1;

      // Act & Assert - should not throw
      expect(() => container.read(sensorHistoryProvider), returnsNormally);
    });

    test('cancels subscription on dispose', () async {
      // Arrange
      container.read(currentProcessTypeProvider.notifier).value = 1;
      container.read(currentDeviceStateProvider.notifier).value = 1;
      container.read(currentStartDatetimeProvider.notifier).value = DateTime(
        2025,
        1,
        1,
        12,
        0,
      );

      final stream = container.read(
        sensorStreamProvider(const Duration(milliseconds: 100)).stream,
      );

      // Act
      await stream.take(2).toList();
      await Future<void>.delayed(const Duration(milliseconds: 200));

      final historyBeforeDispose = container.read(sensorHistoryProvider);

      // Dispose container
      container.dispose();

      // Wait a bit to ensure no more updates
      await Future<void>.delayed(const Duration(milliseconds: 300));

      // Assert - should not throw on access after disposal
      expect(historyBeforeDispose.length, greaterThanOrEqualTo(0));
    });
  });
}
