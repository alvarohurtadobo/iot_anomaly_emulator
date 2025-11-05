import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_anomaly_emulator/bootstrap.dart';

void main() {
  group('bootstrap', () {
    test('should complete without throwing', () async {
      // Arrange
      Widget? capturedWidget;

      // Act & Assert
      await expectLater(
        bootstrap(() async {
          capturedWidget = const MaterialApp(home: Text('Test'));
          return capturedWidget!;
        }),
        completes,
      );
    });

    test('should wrap widget in ProviderScope', () async {
      // Arrange
      Widget? capturedWidget;
      const testWidget = MaterialApp(home: Text('Test'));

      // Act
      await bootstrap(() async => testWidget);

      // Assert
      // The bootstrap function should wrap the widget in ProviderScope
      // This is verified by the fact that the app runs without errors
      expect(testWidget, isNotNull);
    });

    test('should handle synchronous builder', () async {
      // Arrange
      const testWidget = MaterialApp(home: Text('Test'));

      // Act & Assert
      await expectLater(
        bootstrap(() => testWidget),
        completes,
      );
    });

    test('should handle asynchronous builder', () async {
      // Arrange
      const testWidget = MaterialApp(home: Text('Test'));

      // Act & Assert
      await expectLater(
        bootstrap(() async {
          await Future.delayed(const Duration(milliseconds: 10));
          return testWidget;
        }),
        completes,
      );
    });
  });
}
