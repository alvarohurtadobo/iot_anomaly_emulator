import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_anomaly_emulator/home/view/home_page.dart';
import '../../helpers/pump_app.dart';

void main() {
  group('HomePage', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpApp(const HomePage());

      // Assert
      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('renders a Container widget', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpApp(const HomePage());

      // Assert
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('has correct MaterialApp structure', (
      WidgetTester tester,
    ) async {
      // Arrange & Act
      await tester.pumpApp(const HomePage());

      // Assert
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('can be instantiated with key', (WidgetTester tester) async {
      // Arrange
      const key = Key('home_page_key');

      // Act
      await tester.pumpApp(const HomePage(key: key));

      // Assert
      expect(find.byKey(key), findsOneWidget);
    });
  });
}
