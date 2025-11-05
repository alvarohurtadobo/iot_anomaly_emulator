import 'package:flutter_test/flutter_test.dart';
import 'package:iot_anomaly_emulator/devices/model/process_types.dart';

void main() {
  group('ProcessType', () {
    test('should create process type with correct properties', () {
      // Arrange & Act
      const processType = ProcessType(
        id: 1,
        name: 'test_process',
        displayName: 'Test Process',
      );

      // Assert
      expect(processType.id, equals(1));
      expect(processType.name, equals('test_process'));
      expect(processType.displayName, equals('Test Process'));
    });

    test('should have vibrationProcess constant', () {
      // Assert
      expect(vibrationProcess.id, equals(1));
      expect(vibrationProcess.name, equals('vibrations'));
      expect(vibrationProcess.displayName, equals('Vibrations'));
    });

    test('should have oilProcess constant', () {
      // Assert
      expect(oilProcess.id, equals(2));
      expect(oilProcess.name, equals('oil_analysis'));
      expect(oilProcess.displayName, equals('Oil Analysis'));
    });

    test('should have timeProcess constant', () {
      // Assert
      expect(timeProcess.id, equals(3));
      expect(timeProcess.name, equals('hours_operated'));
      expect(timeProcess.displayName, equals('Hours Operated'));
    });

    test('should have processTypesWithId list with all process types', () {
      // Assert
      expect(processTypesWithId, isNotEmpty);
      expect(processTypesWithId.length, equals(3));
      expect(processTypesWithId, contains(vibrationProcess));
      expect(processTypesWithId, contains(oilProcess));
      expect(processTypesWithId, contains(timeProcess));
    });

    test('should have unique IDs in processTypesWithId', () {
      // Arrange
      final ids = processTypesWithId.map((type) => type.id).toList();

      // Assert
      expect(ids.toSet().length, equals(ids.length));
    });

    test('should have all process types with valid properties', () {
      // Act & Assert
      for (final processType in processTypesWithId) {
        expect(processType.id, greaterThan(0));
        expect(processType.name, isNotEmpty);
        expect(processType.displayName, isNotEmpty);
      }
    });

    test('should be immutable', () {
      // Arrange
      const type1 = ProcessType(
        id: 1,
        name: 'test',
        displayName: 'Test',
      );
      const type2 = ProcessType(
        id: 1,
        name: 'test',
        displayName: 'Test',
      );

      // Assert
      expect(type1.id, equals(type2.id));
      expect(type1.name, equals(type2.name));
      expect(type1.displayName, equals(type2.displayName));
    });
  });
}
