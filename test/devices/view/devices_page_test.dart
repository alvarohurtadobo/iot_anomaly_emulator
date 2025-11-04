import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_anomaly_emulator/devices/providers/state_stream_provider.dart';
import 'package:iot_anomaly_emulator/devices/view/devices_page.dart';
import 'package:iot_anomaly_emulator/l10n/l10n.dart';

void main() {
  group('DevicesPage', () {
    testWidgets('should render DevicesPage', (tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: ProviderScope(
              child: const DevicesPage(),
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(DevicesPage), findsOneWidget);
    });

    testWidgets('should show loading indicator when devices are null', (
      tester,
    ) async {
      // Arrange
      final container = ProviderContainer();

      // Act
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: UncontrolledProviderScope(
              container: container,
              child: const DevicesPage(),
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      container.dispose();
    });

    testWidgets('should display devices when loaded', (tester) async {
      // Arrange
      final container = ProviderContainer();

      // Wait for devices to load
      await container.read(
        stateStreamProvider(const Duration(milliseconds: 50)).future,
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: UncontrolledProviderScope(
              container: container,
              child: const DevicesPage(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(Wrap), findsOneWidget);

      container.dispose();
    });

    testWidgets('should render DevicesWrappedList with devices', (tester) async {
      // Arrange
      final container = ProviderContainer();

      // Wait for devices to load
      await container.read(
        stateStreamProvider(const Duration(milliseconds: 50)).future,
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: UncontrolledProviderScope(
              container: container,
              child: const DevicesPage(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(Wrap), findsOneWidget);

      container.dispose();
    });
  });
}
