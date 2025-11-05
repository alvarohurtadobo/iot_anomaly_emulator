import 'package:flutter_test/flutter_test.dart';
import 'package:iot_anomaly_emulator/devices/model/real_time_parameters.dart';

void main() {
  group('RealTimeParameters', () {
    test('should create real time parameters with correct properties', () {
      // Arrange
      final timestamp = DateTime.now();

      // Act
      final parameters = RealTimeParameters(
        vibration: 1.5,
        temperature: 25,
        pressure: 30,
        oilQuality: 80,
        contaminantLevel: 10,
        acidity: 5,
        hoursOperated: 100,
        maintenanceHistory: 3,
        load: 75,
        failure: false,
        anomaly: false,
        timestamp: timestamp,
      );

      // Assert
      expect(parameters.vibration, equals(1.5));
      expect(parameters.temperature, equals(25.0));
      expect(parameters.pressure, equals(30.0));
      expect(parameters.oilQuality, equals(80.0));
      expect(parameters.contaminantLevel, equals(10.0));
      expect(parameters.acidity, equals(5.0));
      expect(parameters.hoursOperated, equals(100.0));
      expect(parameters.maintenanceHistory, equals(3.0));
      expect(parameters.load, equals(75.0));
      expect(parameters.failure, isFalse);
      expect(parameters.anomaly, isFalse);
      expect(parameters.timestamp, equals(timestamp));
    });

    test('should create from JSON with all fields', () {
      // Arrange
      final timestamp = DateTime.now();
      final json = {
        'vibration': '1.5',
        'temperature': '25.0',
        'pressure': '30.0',
        'oil_quality': '80.0',
        'contaminant_level': '10.0',
        'acidity': '5.0',
        'hours_operated': '100.0',
        'maintenance_history': '3.0',
        'load': '75.0',
        'failure': false,
        'anomaly': false,
        'timestamp': timestamp.toIso8601String(),
      };

      // Act
      final parameters = RealTimeParameters.fromJson(json);

      // Assert
      expect(parameters.vibration, equals(1.5));
      expect(parameters.temperature, equals(25.0));
      expect(parameters.pressure, equals(30.0));
      expect(parameters.oilQuality, equals(80.0));
      expect(parameters.contaminantLevel, equals(10.0));
      expect(parameters.acidity, equals(5.0));
      expect(parameters.hoursOperated, equals(100.0));
      expect(parameters.maintenanceHistory, equals(3.0));
      expect(parameters.load, equals(75.0));
      expect(parameters.failure, isFalse);
      expect(parameters.anomaly, isFalse);
      expect(parameters.timestamp, equals(timestamp));
    });

    test('should handle null values in JSON', () {
      // Arrange
      final json = {
        'vibration': null,
        'temperature': null,
        'pressure': null,
        'oil_quality': null,
        'contaminant_level': null,
        'acidity': null,
        'hours_operated': null,
        'maintenance_history': null,
        'load': null,
        'failure': false,
        'anomaly': false,
        'timestamp': null,
      };

      // Act
      final parameters = RealTimeParameters.fromJson(json);

      // Assert
      expect(parameters.vibration, isNull);
      expect(parameters.temperature, isNull);
      expect(parameters.pressure, isNull);
      expect(parameters.oilQuality, isNull);
      expect(parameters.contaminantLevel, isNull);
      expect(parameters.acidity, equals(0));
      expect(parameters.hoursOperated, isNull);
      expect(parameters.maintenanceHistory, isNull);
      expect(parameters.load, isNull);
      expect(parameters.failure, isFalse);
      expect(parameters.anomaly, isFalse);
    });

    test('should handle invalid timestamp in JSON', () {
      // Arrange
      final json = {
        'vibration': '1.5',
        'temperature': '25.0',
        'pressure': '30.0',
        'oil_quality': '80.0',
        'contaminant_level': '10.0',
        'acidity': '5.0',
        'hours_operated': '100.0',
        'maintenance_history': '3.0',
        'load': '75.0',
        'failure': false,
        'anomaly': false,
        'timestamp': 'invalid-date',
      };

      // Act
      final parameters = RealTimeParameters.fromJson(json);

      // Assert
      expect(parameters.timestamp, isNotNull);
      expect(parameters.timestamp, isA<DateTime>());
    });

    test('should convert to JSON correctly', () {
      // Arrange
      final timestamp = DateTime.now();
      final parameters = RealTimeParameters(
        vibration: 1.5,
        temperature: 25,
        pressure: 30,
        oilQuality: 80,
        contaminantLevel: 10,
        acidity: 5,
        hoursOperated: 100,
        maintenanceHistory: 3,
        load: 75,
        failure: false,
        anomaly: false,
        timestamp: timestamp,
      );

      // Act
      final json = parameters.toJson();

      // Assert
      expect(json['vibration'], equals(1.5));
      expect(json['temperature'], equals(25.0));
      expect(json['pressure'], equals(30.0));
      expect(json['oil_quality'], equals(80.0));
      expect(json['contaminant_level'], equals(10.0));
      expect(json['acidity'], equals(5.0));
      expect(json['hours_operated'], equals(100.0));
      expect(json['maintenance_history'], equals(3.0));
      expect(json['load'], equals(75.0));
      expect(json['failure'], isFalse);
      expect(json['anomaly'], isFalse);
      expect(json['timestamp'], isA<String>());
    });

    test('should copy with new values', () {
      // Arrange
      final originalTimestamp = DateTime.now();
      final newTimestamp = DateTime.now().add(const Duration(hours: 1));
      final original = RealTimeParameters(
        vibration: 1.5,
        temperature: 25,
        pressure: 30,
        oilQuality: 80,
        contaminantLevel: 10,
        acidity: 5,
        hoursOperated: 100,
        maintenanceHistory: 3,
        load: 75,
        failure: false,
        anomaly: false,
        timestamp: originalTimestamp,
      );

      // Act
      final copied = original.copyWith(
        vibration: 2,
        temperature: 26,
        failure: true,
        timestamp: newTimestamp,
      );

      // Assert
      expect(copied.vibration, equals(2.0));
      expect(copied.temperature, equals(26.0));
      expect(copied.pressure, equals(30.0)); // unchanged
      expect(copied.failure, isTrue);
      expect(copied.anomaly, isFalse); // unchanged
      expect(copied.timestamp, equals(newTimestamp));
    });

    test('should copy with partial values', () {
      // Arrange
      final timestamp = DateTime.now();
      final original = RealTimeParameters(
        vibration: 1.5,
        temperature: 25,
        pressure: 30,
        oilQuality: 80,
        contaminantLevel: 10,
        acidity: 5,
        hoursOperated: 100,
        maintenanceHistory: 3,
        load: 75,
        failure: false,
        anomaly: false,
        timestamp: timestamp,
      );

      // Act
      final copied = original.copyWith(vibration: 2);

      // Assert
      expect(copied.vibration, equals(2.0));
      expect(copied.temperature, equals(25.0)); // unchanged
      expect(copied.pressure, equals(30.0)); // unchanged
      expect(copied.timestamp, equals(timestamp)); // unchanged
    });

    test('should handle null values in copyWith', () {
      // Arrange
      final originalTimestamp = DateTime.now();
      final newTimestamp = DateTime.now().add(const Duration(hours: 1));
      final original = RealTimeParameters(
        vibration: 1.5,
        temperature: 25,
        pressure: 30,
        oilQuality: 80,
        contaminantLevel: 10,
        acidity: 5,
        hoursOperated: 100,
        maintenanceHistory: 3,
        load: 75,
        failure: false,
        anomaly: false,
        timestamp: originalTimestamp,
      );

      // Act
      final copied = original.copyWith(
        vibration: null,
        temperature: null,
        timestamp: newTimestamp,
      );

      // Assert
      expect(copied.vibration, isNull);
      expect(copied.temperature, isNull);
      expect(copied.timestamp, equals(newTimestamp));
    });

    test('should handle boolean values correctly', () {
      // Arrange
      final timestamp = DateTime.now();
      final withFailure = RealTimeParameters(
        vibration: 1.5,
        temperature: 25,
        pressure: 30,
        oilQuality: 80,
        contaminantLevel: 10,
        acidity: 5,
        hoursOperated: 100,
        maintenanceHistory: 3,
        load: 75,
        failure: true,
        anomaly: true,
        timestamp: timestamp,
      );

      // Assert
      expect(withFailure.failure, isTrue);
      expect(withFailure.anomaly, isTrue);
      expect(withFailure.timestamp, equals(timestamp));
    });

    test('should handle numeric string values in JSON', () {
      // Arrange
      final json = {
        'vibration': '1.5',
        'temperature': '25',
        'pressure': 30, // int instead of string
        'oil_quality': '80.0',
        'contaminant_level': '10.0',
        'acidity': '5.0',
        'hours_operated': '100.0',
        'maintenance_history': '3.0',
        'load': '75.0',
        'failure': false,
        'anomaly': false,
        'timestamp': DateTime.now().toIso8601String(),
      };

      // Act
      final parameters = RealTimeParameters.fromJson(json);

      // Assert
      expect(parameters.vibration, equals(1.5));
      expect(parameters.temperature, equals(25.0));
      expect(parameters.pressure, equals(30.0));
    });
  });
}
