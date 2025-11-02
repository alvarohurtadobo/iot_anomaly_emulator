import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_anomaly_emulator/devices/view/widgets/numeric_tile.dart';
import '../../../helpers/pump_app.dart';

void main() {
  group('NumericTile', () {
    testWidgets('displays title and formatted value', (tester) async {
      // Arrange
      const title = 'Temperature';
      const value = 25.678;

      // Act
      await tester.pumpApp(
        const ProviderScope(
          child: NumericTile(title: title, value: value),
        ),
      );

      // Assert
      expect(find.text(title), findsOneWidget);
      expect(find.text('25.678'), findsOneWidget);
    });

    testWidgets('displays "n/a" when value is null', (tester) async {
      // Arrange
      const title = 'Pressure';
      const double? value = null;

      // Act
      await tester.pumpApp(
        const ProviderScope(
          child: NumericTile(title: title, value: value),
        ),
      );

      // Assert
      expect(find.text(title), findsOneWidget);
      expect(find.text('n/a'), findsOneWidget);
    });

    testWidgets('formats decimal values with 3 decimal places', (tester) async {
      // Test various decimal values
      final testCases = [
        (0.123456, '0.123'),
        (99.999999, '100.000'),
        (3.14159, '3.142'),
        (100.0, '100.000'),
      ];

      for (final testCase in testCases) {
        // Arrange
        final value = testCase.$1;
        final expected = testCase.$2;

        // Act
        await tester.pumpApp(
          ProviderScope(
            child: NumericTile(title: 'Test', value: value),
          ),
        );

        // Assert
        expect(find.text(expected), findsOneWidget);

        // Cleanup
        await tester.pump();
      }
    });

    testWidgets('displays large values correctly', (tester) async {
      // Arrange
      const title = 'Large Value';
      const value = 99999.123;

      // Act
      await tester.pumpApp(
        const ProviderScope(
          child: NumericTile(title: title, value: value),
        ),
      );

      // Assert
      expect(find.text('99999.123'), findsOneWidget);
    });

    testWidgets('displays negative values correctly', (tester) async {
      // Arrange
      const title = 'Difference';
      const value = -15.789;

      // Act
      await tester.pumpApp(
        const ProviderScope(
          child: NumericTile(title: title, value: value),
        ),
      );

      // Assert
      expect(find.text('-15.789'), findsOneWidget);
    });

    testWidgets('displays zero correctly', (tester) async {
      // Arrange
      const title = 'Zero Value';
      const value = 0.0;

      // Act
      await tester.pumpApp(
        const ProviderScope(
          child: NumericTile(title: title, value: value),
        ),
      );

      // Assert
      expect(find.text('0.000'), findsOneWidget);
    });

    testWidgets('has correct layout with Row', (tester) async {
      // Arrange
      const title = 'Layout Test';
      const value = 42.5;

      // Act
      await tester.pumpApp(
        const ProviderScope(
          child: NumericTile(title: title, value: value),
        ),
      );

      // Assert
      expect(find.byType(Row), findsOneWidget);
    });

    testWidgets('applies horizontal padding', (tester) async {
      // Arrange
      const title = 'Padding Test';
      const value = 10.0;

      // Act
      await tester.pumpApp(
        const ProviderScope(
          child: NumericTile(title: title, value: value),
        ),
      );

      // Assert
      expect(find.byType(Padding), findsOneWidget);
    });

    testWidgets('displays multiple tiles correctly', (tester) async {
      // Arrange
      const tiles = [
        NumericTile(title: 'Temp', value: 25),
        NumericTile(title: 'Pres', value: 101.3),
        NumericTile(title: 'Humid', value: null),
      ];

      // Act
      await tester.pumpApp(
        const ProviderScope(
          child: Column(
            children: tiles,
          ),
        ),
      );

      // Assert
      expect(find.text('Temp'), findsOneWidget);
      expect(find.text('25.000'), findsOneWidget);
      expect(find.text('Pres'), findsOneWidget);
      expect(find.text('101.300'), findsOneWidget);
      expect(find.text('Humid'), findsOneWidget);
      expect(find.text('n/a'), findsOneWidget);
    });

    testWidgets('displays very small values correctly', (tester) async {
      // Arrange
      const title = 'Tiny Value';
      const value = 0.001;

      // Act
      await tester.pumpApp(
        const ProviderScope(
          child: NumericTile(title: title, value: value),
        ),
      );

      // Assert
      expect(find.text('0.001'), findsOneWidget);
    });
  });
}
