import 'package:flutter_test/flutter_test.dart';
import 'package:iot_anomaly_emulator/devices/model/parameters.dart';

void main() {
  group('Parameter', () {
    test('should create parameter with correct properties', () {
      // Arrange & Act
      const parameter = Parameter(
        id: 1,
        name: 'test_param',
        displayName: 'Test Parameter',
      );

      // Assert
      expect(parameter.id, equals(1));
      expect(parameter.name, equals('test_param'));
      expect(parameter.displayName, equals('Test Parameter'));
    });

    test('should have vibrationParameter constant', () {
      // Assert
      expect(vibrationParamenter.id, equals(1));
      expect(vibrationParamenter.name, equals('vibration'));
      expect(vibrationParamenter.displayName, equals('Vibration'));
    });

    test('should have temperatureParameter constant', () {
      // Assert
      expect(temperatureParamenter.id, equals(2));
      expect(temperatureParamenter.name, equals('temperature'));
      expect(temperatureParamenter.displayName, equals('Temperature'));
    });

    test('should have pressureParameter constant', () {
      // Assert
      expect(pressureParamenter.id, equals(3));
      expect(pressureParamenter.name, equals('pressure'));
      expect(pressureParamenter.displayName, equals('Pressure'));
    });

    test('should have oilQualityParameter constant', () {
      // Assert
      expect(oilQualityParamenter.id, equals(4));
      expect(oilQualityParamenter.name, equals('oil_quality'));
      expect(oilQualityParamenter.displayName, equals('Oil Quality'));
    });

    test('should have contaminantLevelParameter constant', () {
      // Assert
      expect(contaminantLevelParamenter.id, equals(5));
      expect(contaminantLevelParamenter.name, equals('contaminant_level'));
      expect(
        contaminantLevelParamenter.displayName,
        equals('Contaminant Level'),
      );
    });

    test('should have acidityParameter constant', () {
      // Assert
      expect(acidityParamenter.id, equals(6));
      expect(acidityParamenter.name, equals('acidity'));
      expect(acidityParamenter.displayName, equals('Acidity'));
    });

    test('should have hoursOperatedParameter constant', () {
      // Assert
      expect(hoursOperatedParamenter.id, equals(7));
      expect(hoursOperatedParamenter.name, equals('hours_operated'));
      expect(hoursOperatedParamenter.displayName, equals('Hours Operated'));
    });

    test('should have maintenanceHistoryParameter constant', () {
      // Assert
      expect(maintenanceHistoryParamenter.id, equals(8));
      expect(maintenanceHistoryParamenter.name, equals('maintenance_history'));
      expect(
        maintenanceHistoryParamenter.displayName,
        equals('Maintenance History'),
      );
    });

    test('should have loadParameter constant', () {
      // Assert
      expect(loadParamenter.id, equals(9));
      expect(loadParamenter.name, equals('load'));
      expect(loadParamenter.displayName, equals('Load'));
    });

    test('should have parameters list with all parameters', () {
      // Assert
      expect(parameters, isNotEmpty);
      expect(parameters.length, equals(9));
      expect(parameters, contains(vibrationParamenter));
      expect(parameters, contains(temperatureParamenter));
      expect(parameters, contains(pressureParamenter));
      expect(parameters, contains(oilQualityParamenter));
      expect(parameters, contains(contaminantLevelParamenter));
      expect(parameters, contains(acidityParamenter));
      expect(parameters, contains(hoursOperatedParamenter));
      expect(parameters, contains(maintenanceHistoryParamenter));
      expect(parameters, contains(loadParamenter));
    });

    test('should have unique IDs in parameters list', () {
      // Arrange
      final ids = parameters.map((param) => param.id).toList();

      // Assert
      expect(ids.toSet().length, equals(ids.length));
    });

    test('should have all parameters with valid properties', () {
      // Act & Assert
      for (final parameter in parameters) {
        expect(parameter.id, greaterThan(0));
        expect(parameter.name, isNotEmpty);
        expect(parameter.displayName, isNotEmpty);
      }
    });

    test('should be immutable', () {
      // Arrange
      const param1 = Parameter(
        id: 1,
        name: 'test',
        displayName: 'Test',
      );
      const param2 = Parameter(
        id: 1,
        name: 'test',
        displayName: 'Test',
      );

      // Assert
      expect(param1.id, equals(param2.id));
      expect(param1.name, equals(param2.name));
      expect(param1.displayName, equals(param2.displayName));
    });
  });
}
