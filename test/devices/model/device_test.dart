import 'package:flutter_test/flutter_test.dart';
import 'package:iot_anomaly_emulator/devices/model/device.dart';
import 'package:iot_anomaly_emulator/devices/model/process_types.dart';
import 'package:iot_anomaly_emulator/devices/model/types.dart';

void main() {
  group('EmulatedDevice', () {
    test('should create device with correct properties', () {
      // Arrange & Act
      const device = EmulatedDevice(
        id: 1,
        name: 'Test Device',
        type: DeviceTypes.imm,
        processType: vibrationProcess,
        state: true,
      );

      // Assert
      expect(device.id, equals(1));
      expect(device.name, equals('Test Device'));
      expect(device.type, equals(DeviceTypes.imm));
      expect(device.processType, equals(vibrationProcess));
      expect(device.state, isTrue);
    });

    test('should create device from JSON', () {
      // Arrange
      final json = {
        'id': 2,
        'name': 'Arc Solder',
        'type': DeviceTypes.arc,
        'process_type': oilProcess,
        'state': false,
      };

      // Act
      final device = EmulatedDevice.fromJson(json);

      // Assert
      expect(device.id, equals(2));
      expect(device.name, equals('Arc Solder'));
      expect(device.type, equals(DeviceTypes.arc));
      expect(device.processType, equals(oilProcess));
      expect(device.state, isFalse);
    });

    test('should handle null id in JSON', () {
      // Arrange
      final json = {
        'id': null,
        'name': 'Test Device',
        'type': DeviceTypes.other,
        'process_type': timeProcess,
        'state': true,
      };

      // Act
      final device = EmulatedDevice.fromJson(json);

      // Assert
      expect(device.id, equals(0));
    });

    test('should convert device to JSON', () {
      // Arrange
      const device = EmulatedDevice(
        id: 3,
        name: 'DeMag300',
        type: DeviceTypes.other,
        processType: vibrationProcess,
        state: true,
      );

      // Act
      final json = device.toJson();

      // Assert
      expect(json['id'], equals(3));
      expect(json['name'], equals('DeMag300'));
      expect(json['type'], equals(DeviceTypes.other));
      expect(json['process_type'], equals(vibrationProcess));
      expect(json['state'], isTrue);
    });

    test('should copy device with new values', () {
      // Arrange
      const original = EmulatedDevice(
        id: 1,
        name: 'Original',
        type: DeviceTypes.imm,
        processType: vibrationProcess,
        state: true,
      );

      // Act
      final copied = original.copyWith(
        id: 2,
        name: 'Copied',
        state: false,
      );

      // Assert
      expect(copied.id, equals(2));
      expect(copied.name, equals('Copied'));
      expect(copied.type, equals(DeviceTypes.imm));
      expect(copied.processType, equals(vibrationProcess));
      expect(copied.state, isFalse);
    });

    test('should copy device with partial values', () {
      // Arrange
      const original = EmulatedDevice(
        id: 1,
        name: 'Original',
        type: DeviceTypes.imm,
        processType: vibrationProcess,
        state: true,
      );

      // Act
      final copied = original.copyWith(state: false);

      // Assert
      expect(copied.id, equals(1));
      expect(copied.name, equals('Original'));
      expect(copied.type, equals(DeviceTypes.imm));
      expect(copied.processType, equals(vibrationProcess));
      expect(copied.state, isFalse);
    });

    test('should copy device without changes', () {
      // Arrange
      const original = EmulatedDevice(
        id: 1,
        name: 'Original',
        type: DeviceTypes.imm,
        processType: vibrationProcess,
        state: true,
      );

      // Act
      final copied = original.copyWith();

      // Assert
      expect(copied.id, equals(original.id));
      expect(copied.name, equals(original.name));
      expect(copied.type, equals(original.type));
      expect(copied.processType, equals(original.processType));
      expect(copied.state, equals(original.state));
    });

    test('should create device with all types', () {
      // Act & Assert
      const immDevice = EmulatedDevice(
        id: 1,
        name: 'IMM',
        type: DeviceTypes.imm,
        processType: vibrationProcess,
        state: true,
      );
      expect(immDevice.type, equals(DeviceTypes.imm));

      const arcDevice = EmulatedDevice(
        id: 2,
        name: 'ARC',
        type: DeviceTypes.arc,
        processType: oilProcess,
        state: true,
      );
      expect(arcDevice.type, equals(DeviceTypes.arc));

      const otherDevice = EmulatedDevice(
        id: 3,
        name: 'Other',
        type: DeviceTypes.other,
        processType: timeProcess,
        state: true,
      );
      expect(otherDevice.type, equals(DeviceTypes.other));
    });

    test('should handle all process types', () {
      // Arrange & Act
      const vibrationDevice = EmulatedDevice(
        id: 1,
        name: 'Vibration',
        type: DeviceTypes.imm,
        processType: vibrationProcess,
        state: true,
      );

      const oilDevice = EmulatedDevice(
        id: 2,
        name: 'Oil',
        type: DeviceTypes.arc,
        processType: oilProcess,
        state: true,
      );

      const timeDevice = EmulatedDevice(
        id: 3,
        name: 'Time',
        type: DeviceTypes.other,
        processType: timeProcess,
        state: true,
      );

      // Assert
      expect(vibrationDevice.processType, equals(vibrationProcess));
      expect(oilDevice.processType, equals(oilProcess));
      expect(timeDevice.processType, equals(timeProcess));
    });

    test('should handle boolean state in JSON', () {
      // Arrange
      final jsonTrue = {
        'id': 1,
        'name': 'Device',
        'type': DeviceTypes.imm,
        'process_type': vibrationProcess,
        'state': true,
      };

      final jsonFalse = {
        'id': 2,
        'name': 'Device',
        'type': DeviceTypes.imm,
        'process_type': vibrationProcess,
        'state': false,
      };

      // Act
      final deviceTrue = EmulatedDevice.fromJson(jsonTrue);
      final deviceFalse = EmulatedDevice.fromJson(jsonFalse);

      // Assert
      expect(deviceTrue.state, isTrue);
      expect(deviceFalse.state, isFalse);
    });
  });

  group('emulatedDevices list', () {
    test('should contain expected devices', () {
      // Assert
      expect(emulatedDevices, isNotEmpty);
      expect(emulatedDevices.length, greaterThan(0));
    });

    test('should have unique device IDs', () {
      // Arrange
      final ids = emulatedDevices.map((device) => device.id).toList();

      // Assert
      expect(ids.toSet().length, equals(ids.length));
    });

    test('should have all devices with valid properties', () {
      // Act & Assert
      for (final device in emulatedDevices) {
        expect(device.id, greaterThan(0));
        expect(device.name, isNotEmpty);
        expect(device.type, isNotNull);
        expect(device.processType, isNotNull);
      }
    });
  });
}
