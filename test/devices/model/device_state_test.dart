import 'package:flutter_test/flutter_test.dart';
import 'package:iot_anomaly_emulator/devices/model/device_state.dart';

void main() {
  group('DeviceState', () {
    test('should create device state with correct properties', () {
      // Arrange & Act
      const state = DeviceState(
        id: 1,
        name: 'test_state',
        displayName: 'Test State',
      );

      // Assert
      expect(state.id, equals(1));
      expect(state.name, equals('test_state'));
      expect(state.displayName, equals('Test State'));
    });

    test('should have vibrationProcess constant', () {
      // Assert
      expect(vibrationProcess.id, equals(0));
      expect(vibrationProcess.name, equals('disabled'));
      expect(vibrationProcess.displayName, equals('Out of work'));
    });

    test('should have oilProcess constant', () {
      // Assert
      expect(oilProcess.id, equals(1));
      expect(oilProcess.name, equals('normal'));
      expect(oilProcess.displayName, equals('Normal operation'));
    });

    test('should have timeProcess constant', () {
      // Assert
      expect(timeProcess.id, equals(2));
      expect(timeProcess.name, equals('maintenance'));
      expect(timeProcess.displayName, equals('Under Maintenance'));
    });

    test('should have deviceStatesWithId list with all states', () {
      // Assert
      expect(deviceStatesWithId, isNotEmpty);
      expect(deviceStatesWithId.length, equals(3));
      expect(deviceStatesWithId, contains(vibrationProcess));
      expect(deviceStatesWithId, contains(oilProcess));
      expect(deviceStatesWithId, contains(timeProcess));
    });

    test('should have unique IDs in deviceStatesWithId', () {
      // Arrange
      final ids = deviceStatesWithId.map((state) => state.id).toList();

      // Assert
      expect(ids.toSet().length, equals(ids.length));
    });

    test('should have all states with valid properties', () {
      // Act & Assert
      for (final state in deviceStatesWithId) {
        expect(state.id, greaterThanOrEqualTo(0));
        expect(state.name, isNotEmpty);
        expect(state.displayName, isNotEmpty);
      }
    });

    test('should be immutable', () {
      // Arrange
      const state1 = DeviceState(
        id: 1,
        name: 'test',
        displayName: 'Test',
      );
      const state2 = DeviceState(
        id: 1,
        name: 'test',
        displayName: 'Test',
      );

      // Assert
      expect(state1.id, equals(state2.id));
      expect(state1.name, equals(state2.name));
      expect(state1.displayName, equals(state2.displayName));
    });
  });
}
