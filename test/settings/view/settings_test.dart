import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_anomaly_emulator/settings/view/settings.dart';

void main() {
  group('SettingsPage', () {
    testWidgets('should render SettingsPage', (tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SettingsPage(),
          ),
        ),
      );

      // Assert
      expect(find.byType(SettingsPage), findsOneWidget);
    });

    testWidgets('should render empty Container', (tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SettingsPage(),
          ),
        ),
      );

      // Assert
      expect(find.byType(Container), findsOneWidget);
    });

    test('should be a StatelessWidget', () {
      // Assert
      const page = SettingsPage();
      expect(page, isA<StatelessWidget>());
    });
  });
}
