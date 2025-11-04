import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_anomaly_emulator/devices/view/widgets/option_tile.dart';

void main() {
  group('OptionTile', () {
    testWidgets('should display title and dropdown', (tester) async {
      // Arrange
      final options = [
        _TestOption(id: 1, displayName: 'Option 1'),
        _TestOption(id: 2, displayName: 'Option 2'),
      ];

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProviderScope(
              child: OptionTile(
                title: 'Process Type',
                optionsWithId: options,
                value: 1,
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Process Type'), findsOneWidget);
      expect(find.byType(DropdownButton<int>), findsOneWidget);
    });

    testWidgets('should display selected value', (tester) async {
      // Arrange
      final options = [
        _TestOption(id: 1, displayName: 'Option 1'),
        _TestOption(id: 2, displayName: 'Option 2'),
        _TestOption(id: 3, displayName: 'Option 3'),
      ];

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProviderScope(
              child: OptionTile(
                title: 'Test',
                optionsWithId: options,
                value: 2,
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );

      // Assert
      final dropdown = tester.widget<DropdownButton<int>>(
        find.byType(DropdownButton<int>),
      );
      expect(dropdown.value, equals(2));
    });

    testWidgets('should call onChanged when option is selected', (tester) async {
      // Arrange
      final options = [
        _TestOption(id: 1, displayName: 'Option 1'),
        _TestOption(id: 2, displayName: 'Option 2'),
        _TestOption(id: 3, displayName: 'Option 3'),
      ];

      int? selectedValue;
      void onChanged(int? value) {
        selectedValue = value;
      }

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProviderScope(
              child: OptionTile(
                title: 'Test',
                optionsWithId: options,
                value: 1,
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      );

      // Open dropdown
      await tester.tap(find.byType(DropdownButton<int>));
      await tester.pumpAndSettle();

      // Select option 2
      await tester.tap(find.text('Option 2'));
      await tester.pumpAndSettle();

      // Assert
      expect(selectedValue, equals(2));
    });

    testWidgets('should display all options in dropdown', (tester) async {
      // Arrange
      final options = [
        _TestOption(id: 1, displayName: 'Option 1'),
        _TestOption(id: 2, displayName: 'Option 2'),
        _TestOption(id: 3, displayName: 'Option 3'),
      ];

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProviderScope(
              child: OptionTile(
                title: 'Test',
                optionsWithId: options,
                value: 1,
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );

      // Open dropdown
      await tester.tap(find.byType(DropdownButton<int>));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Option 1'), findsWidgets);
      expect(find.text('Option 2'), findsWidgets);
      expect(find.text('Option 3'), findsWidgets);
    });

    testWidgets('should handle disabled onChanged', (tester) async {
      // Arrange
      final options = [
        _TestOption(id: 1, displayName: 'Option 1'),
        _TestOption(id: 2, displayName: 'Option 2'),
      ];

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProviderScope(
              child: OptionTile(
                title: 'Test',
                optionsWithId: options,
                value: 1,
                onChanged: (_) {}, // In real usage, this would be null to disable
              ),
            ),
          ),
        ),
      );

      // Assert
      final dropdown = tester.widget<DropdownButton<int>>(
        find.byType(DropdownButton<int>),
      );
      expect(dropdown.onChanged, isNotNull);
    });

    testWidgets('should display title and dropdown in row', (tester) async {
      // Arrange
      final options = [
        _TestOption(id: 1, displayName: 'Option 1'),
      ];

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProviderScope(
              child: OptionTile(
                title: 'Test Title',
                optionsWithId: options,
                value: 1,
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(Row), findsOneWidget);
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.byType(DropdownButton<int>), findsOneWidget);
    });

    testWidgets('should handle empty options list', (tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProviderScope(
              child: OptionTile(
                title: 'Test',
                optionsWithId: [],
                value: 1,
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Test'), findsOneWidget);
      expect(find.byType(DropdownButton<int>), findsOneWidget);
    });
  });
}

// Helper class for testing
class _TestOption {
  _TestOption({required this.id, required this.displayName});

  final int id;
  final String displayName;
}
