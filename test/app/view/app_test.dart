import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_anomaly_emulator/app/view/app.dart';
import 'package:iot_anomaly_emulator/l10n/l10n.dart';

void main() {
  group('App', () {
    testWidgets('renders MaterialApp.router', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const ProviderScope(
          child: App(),
        ),
      );

      // Assert
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('has debugShowCheckedModeBanner set to false', (
      WidgetTester tester,
    ) async {
      // Arrange & Act
      await tester.pumpWidget(
        const ProviderScope(
          child: App(),
        ),
      );

      // Assert
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.debugShowCheckedModeBanner, isFalse);
    });

    testWidgets('uses Material3', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const ProviderScope(
          child: App(),
        ),
      );

      // Assert
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme?.useMaterial3, isTrue);
    });

    testWidgets('has localizations delegates configured', (
      WidgetTester tester,
    ) async {
      // Arrange & Act
      await tester.pumpWidget(
        const ProviderScope(
          child: App(),
        ),
      );

      // Assert
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(
        materialApp.localizationsDelegates,
        equals(AppLocalizations.localizationsDelegates),
      );
    });

    testWidgets('has supported locales configured', (
      WidgetTester tester,
    ) async {
      // Arrange & Act
      await tester.pumpWidget(
        const ProviderScope(
          child: App(),
        ),
      );

      // Assert
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(
        materialApp.supportedLocales,
        equals(AppLocalizations.supportedLocales),
      );
    });

    testWidgets('has router configured', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const ProviderScope(
          child: App(),
        ),
      );

      // Assert
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.routerConfig, isNotNull);
    });

    testWidgets('can be instantiated with key', (WidgetTester tester) async {
      // Arrange
      const key = Key('app_key');

      // Act
      await tester.pumpWidget(
        const ProviderScope(
          child: App(key: key),
        ),
      );

      // Assert
      expect(find.byKey(key), findsOneWidget);
    });
  });
}
