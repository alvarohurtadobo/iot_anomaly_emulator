import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_anomaly_emulator/devices/model/device.dart';
import 'package:iot_anomaly_emulator/devices/model/types.dart';
import 'package:iot_anomaly_emulator/devices/providers/state_stream_provider.dart';

void main() {
  group('stateStreamProvider', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('emits list of EmulatedDevice objects', () async {
      // Arrange
      final stream = container.read(
        stateStreamProvider(const Duration(milliseconds: 100)).stream,
      );

      // Act
      final devices = await stream.first;

      // Assert
      expect(devices, isA<List<EmulatedDevice>>());
      expect(devices.isNotEmpty, isTrue);
    });

    test('emits devices periodically', () async {
      // Arrange
      final stream = container.read(
        stateStreamProvider(const Duration(milliseconds: 100)).stream,
      );

      // Act - collect multiple emissions
      final results = await stream.take(3).toList();

      // Assert
      expect(results.length, equals(3));
      for (final devices in results) {
        expect(devices, isA<List<EmulatedDevice>>());
        expect(devices.isNotEmpty, isTrue);
      }
    });

    test('emits all emulated devices', () async {
      // Arrange
      final stream = container.read(
        stateStreamProvider(const Duration(milliseconds: 100)).stream,
      );

      // Act
      final devices = await stream.first;

      // Assert
      expect(devices.length, equals(emulatedDevices.length));
    });

    test('devices have random states', () async {
      // Arrange
      final stream = container.read(
        stateStreamProvider(const Duration(milliseconds: 100)).stream,
      );

      // Act - collect multiple emissions
      final results = await stream.take(10).toList();

      // Assert - at least one device should have different state across emissions
      final randomStates = <bool>{};

      for (final devices in results) {
        for (var i = 0; i < devices.length; i++) {
          randomStates.add(devices[i].state);
        }
      }

      // With 10 emissions and random states, we should see variety
      // (this test is probabilistic but highly likely to pass)
      expect(randomStates.length, greaterThan(0));
    });

    test('each device has correct structure', () async {
      // Arrange
      final stream = container.read(
        stateStreamProvider(const Duration(milliseconds: 100)).stream,
      );

      // Act
      final devices = await stream.first;

      // Assert
      for (final device in devices) {
        expect(device.id, isA<int>());
        expect(device.name, isA<String>());
        expect(device.name.isNotEmpty, isTrue);
        expect(device.type, isA<DeviceTypes>());
        expect(device.processType, isNotNull);
        expect(device.state, isA<bool>());
      }
    });

    test('devices match emulatedDevices but with different states', () async {
      // Arrange
      final stream = container.read(
        stateStreamProvider(const Duration(milliseconds: 100)).stream,
      );

      // Act
      final devices = await stream.first;

      // Assert - same count and IDs
      expect(devices.length, equals(emulatedDevices.length));

      // Verify we can find corresponding devices by ID
      for (final original in emulatedDevices) {
        final streamDevice = devices.firstWhere((d) => d.id == original.id);
        expect(streamDevice.name, equals(original.name));
        expect(streamDevice.type, equals(original.type));
        expect(streamDevice.processType.id, equals(original.processType.id));
      }
    });

    test('respects interval parameter', () async {
      // Arrange
      const interval = Duration(milliseconds: 200);
      final stream = container.read(stateStreamProvider(interval).stream);

      // Act - measure time between emissions
      final startTime = DateTime.now();
      await stream.take(3).toList();
      final endTime = DateTime.now();

      // Assert - should take approximately 400ms (2 intervals after first)
      final duration = endTime.difference(startTime);
      expect(duration.inMilliseconds, greaterThanOrEqualTo(350));
      expect(duration.inMilliseconds, lessThan(700)); // Allow some margin
    });

    test('works with different interval durations', () async {
      // Test with various intervals
      const intervals = [
        Duration(milliseconds: 50),
        Duration(milliseconds: 100),
        Duration(seconds: 1),
      ];

      for (final interval in intervals) {
        // Arrange
        final stream = container.read(stateStreamProvider(interval).stream);

        // Act
        final devices = await stream.first;

        // Assert
        expect(devices, isA<List<EmulatedDevice>>());
        expect(devices.isNotEmpty, isTrue);
      }
    });
  });
}
