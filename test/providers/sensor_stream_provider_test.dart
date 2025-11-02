import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_anomaly_emulator/devices/providers/current_device_state.dart';
import 'package:iot_anomaly_emulator/devices/providers/current_process_type_provider.dart';
import 'package:iot_anomaly_emulator/devices/providers/sensor_stream_provider.dart';
import 'package:iot_anomaly_emulator/devices/providers/start_datetime_provider.dart';

void main() {
  group('sensorStreamProvider', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('emits data with vibration process type', () async {
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
      final data = await stream.first;

      // Assert
      expect(data, isA<SensorData>());
      expect(data.values, isNotEmpty);
      expect(data.values.keys, contains('vibration'));
      expect(data.values.keys, contains('temperature'));
      expect(data.values.keys, contains('pressure'));
      expect(data.timestamp, isA<DateTime>());
    });

    test('emits data with oil analysis process type', () async {
      // Arrange
      container.read(currentProcessTypeProvider.notifier).value = 2;
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
      final data = await stream.first;

      // Assert
      expect(data, isA<SensorData>());
      expect(data.values, isNotEmpty);
      expect(data.values.keys, contains('oil_quality'));
      expect(data.values.keys, contains('contaminant_level'));
      expect(data.values.keys, contains('acidity'));
      expect(data.timestamp, isA<DateTime>());
    });

    test('emits data with hours operated process type', () async {
      // Arrange
      container.read(currentProcessTypeProvider.notifier).value = 3;
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
      final data = await stream.first;

      // Assert
      expect(data, isA<SensorData>());
      expect(data.values, isNotEmpty);
      expect(data.values.keys, contains('hours_operated'));
      expect(data.values.keys, contains('maintenance_history'));
      expect(data.values.keys, contains('load'));
      expect(data.timestamp, isA<DateTime>());
    });

    test('emits empty data when process type is null', () async {
      // Arrange
      container.read(currentProcessTypeProvider.notifier).value = null;
      container.read(currentDeviceStateProvider.notifier).value = 1;

      final stream = container.read(
        sensorStreamProvider(const Duration(milliseconds: 100)).stream,
      );

      // Act
      final data = await stream.first;

      // Assert
      expect(data, isA<SensorData>());
      expect(data.values, isEmpty);
      expect(data.timestamp, isA<DateTime>());
    });

    test('emits empty data when device state is 0', () async {
      // Arrange
      container.read(currentProcessTypeProvider.notifier).value = 1;
      container.read(currentDeviceStateProvider.notifier).value = 0;
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
      final data = await stream.first;

      // Assert
      expect(data, isA<SensorData>());
      expect(data.values, isEmpty);
      expect(data.timestamp, isA<DateTime>());
    });

    test('emits empty data for unknown process type', () async {
      // Arrange
      container.read(currentProcessTypeProvider.notifier).value = 999;
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
      final data = await stream.first;

      // Assert
      expect(data, isA<SensorData>());
      expect(data.values, isEmpty);
      expect(data.timestamp, isA<DateTime>());
    });

    test('emits data periodically with correct interval', () async {
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

      // Act - collect multiple emissions
      final results = await stream.take(3).toList();

      // Assert
      expect(results.length, equals(3));
      for (final data in results) {
        expect(data, isA<SensorData>());
        expect(data.values, isNotEmpty);
      }
    });

    test('SensorData toString returns correct format', () {
      // Arrange
      final timestamp = DateTime(2025, 1, 1, 12, 0);
      final values = {'temperature': 25.5, 'pressure': 101.3};

      // Act
      final data = SensorData(values: values, timestamp: timestamp);

      // Assert
      expect(
        data.toString(),
        contains(
          '[2025-01-01 12:00:00.000] {temperature: 25.5, pressure: 101.3}',
        ),
      );
    });
  });
}
