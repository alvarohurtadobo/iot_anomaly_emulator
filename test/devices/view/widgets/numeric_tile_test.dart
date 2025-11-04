import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_anomaly_emulator/devices/view/widgets/numeric_tile.dart';

void main() {
  group('NumericTile', () {
    testWidgets('should display title and value', (tester) async {
      // Arrange
      const numericTile = NumericTile(
        title: 'Temperature',
        value: 25.5,
      );

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProviderScope(child: numericTile),
          ),
        ),
      );

      // Assert
      expect(find.text('Temperature'), findsOneWidget);
      expect(find.text('25.500'), findsOneWidget);
    });

    testWidgets('should display n/a when value is null', (tester) async {
      // Arrange
      const numericTile = NumericTile(
        title: 'Pressure',
        value: null,
      );

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProviderScope(child: numericTile),
          ),
        ),
      );

      // Assert
      expect(find.text('Pressure'), findsOneWidget);
      expect(find.text('n/a'), findsOneWidget);
    });

    testWidgets('should format value with 3 decimal places', (tester) async {
      // Arrange
      const numericTile = NumericTile(
        title: 'Vibration',
        value: 1.23456789,
      );

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProviderScope(child: numericTile),
          ),
        ),
      );

      // Assert
      expect(find.text('1.235'), findsOneWidget);
    });

    testWidgets('should handle zero value', (tester) async {
      // Arrange
      const numericTile = NumericTile(
        title: 'Value',
        value: 0,
      );

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProviderScope(child: numericTile),
          ),
        ),
      );

      // Assert
      expect(find.text('0.000'), findsOneWidget);
    });

    testWidgets('should handle negative values', (tester) async {
      // Arrange
      const numericTile = NumericTile(
        title: 'Temperature',
        value: -10.5,
      );

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProviderScope(child: numericTile),
          ),
        ),
      );

      // Assert
      expect(find.text('-10.500'), findsOneWidget);
    });

    testWidgets('should handle large values', (tester) async {
      // Arrange
      const numericTile = NumericTile(
        title: 'Load',
        value: 999999.123,
      );

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProviderScope(child: numericTile),
          ),
        ),
      );

      // Assert
      expect(find.text('999999.123'), findsOneWidget);
    });

    testWidgets('should display title and value in row', (tester) async {
      // Arrange
      const numericTile = NumericTile(
        title: 'Test',
        value: 42,
      );

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProviderScope(child: numericTile),
          ),
        ),
      );

      // Assert
      expect(find.byType(Row), findsOneWidget);
      expect(find.text('Test'), findsOneWidget);
      expect(find.text('42.000'), findsOneWidget);
    });

    test('should have correct properties', () {
      // Arrange & Act
      const numericTile = NumericTile(
        title: 'Test Title',
        value: 123.456,
      );

      // Assert
      expect(numericTile.title, equals('Test Title'));
      expect(numericTile.value, equals(123.456));
    });
  });
}
