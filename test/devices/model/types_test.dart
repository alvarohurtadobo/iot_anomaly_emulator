import 'package:flutter_test/flutter_test.dart';
import 'package:iot_anomaly_emulator/devices/model/types.dart';

void main() {
  group('DeviceTypes', () {
    test('should have imm value', () {
      // Assert
      expect(DeviceTypes.imm, isNotNull);
      expect(DeviceTypes.imm.toString(), equals('DeviceTypes.imm'));
    });

    test('should have arc value', () {
      // Assert
      expect(DeviceTypes.arc, isNotNull);
      expect(DeviceTypes.arc.toString(), equals('DeviceTypes.arc'));
    });

    test('should have other value', () {
      // Assert
      expect(DeviceTypes.other, isNotNull);
      expect(DeviceTypes.other.toString(), equals('DeviceTypes.other'));
    });

    test('should have all three values', () {
      // Assert
      expect(DeviceTypes.values.length, equals(3));
      expect(DeviceTypes.values, contains(DeviceTypes.imm));
      expect(DeviceTypes.values, contains(DeviceTypes.arc));
      expect(DeviceTypes.values, contains(DeviceTypes.other));
    });

    test('should have unique values', () {
      // Arrange
      const values = DeviceTypes.values;

      // Assert
      expect(values.toSet().length, equals(values.length));
    });

    test('should be comparable', () {
      // Assert
      expect(DeviceTypes.imm == DeviceTypes.imm, isTrue);
      expect(DeviceTypes.imm == DeviceTypes.arc, isFalse);
      expect(DeviceTypes.arc == DeviceTypes.other, isFalse);
    });

    test('should have index values', () {
      // Assert
      expect(DeviceTypes.imm.index, equals(0));
      expect(DeviceTypes.arc.index, equals(1));
      expect(DeviceTypes.other.index, equals(2));
    });

    test('should be usable in switch statements', () {
      // Arrange
      String getTypeName(DeviceTypes type) {
        switch (type) {
          case DeviceTypes.imm:
            return 'imm';
          case DeviceTypes.arc:
            return 'arc';
          case DeviceTypes.other:
            return 'other';
        }
      }

      // Act & Assert
      expect(getTypeName(DeviceTypes.imm), equals('imm'));
      expect(getTypeName(DeviceTypes.arc), equals('arc'));
      expect(getTypeName(DeviceTypes.other), equals('other'));
    });
  });
}
