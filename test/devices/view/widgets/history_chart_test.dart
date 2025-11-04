import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_anomaly_emulator/devices/model/parameters.dart';
import 'package:iot_anomaly_emulator/devices/providers/current_process_type_provider.dart';
import 'package:iot_anomaly_emulator/devices/providers/sensor_stream_provider.dart';
import 'package:iot_anomaly_emulator/devices/view/widgets/history_chart.dart';

void main() {
  group('HistoryChart', () {
    testWidgets('should render chart widget', (tester) async {
      // Arrange
      final container = ProviderContainer();
      container.read(currentProcessTypeProvider.notifier).value = 1;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UncontrolledProviderScope(
              container: container,
              child: const HistoryChart(),
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(HistoryChart), findsOneWidget);

      container.dispose();
    });

    testWidgets('should display labels for process type 1', (tester) async {
      // Arrange
      final container = ProviderContainer();
      container.read(currentProcessTypeProvider.notifier).value = 1;

      // Add some history data
      await container.read(
        sensorStreamProvider(const Duration(milliseconds: 50)).future,
      );
      await Future<void>.delayed(const Duration(milliseconds: 200));

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UncontrolledProviderScope(
              container: container,
              child: const HistoryChart(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Assert
      expect(
        find.text(parameters[0].displayName),
        findsAtLeastNWidgets(1),
      );
      expect(
        find.text(parameters[1].displayName),
        findsAtLeastNWidgets(1),
      );
      expect(
        find.text(parameters[2].displayName),
        findsAtLeastNWidgets(1),
      );

      container.dispose();
    });

    testWidgets('should display labels for process type 2', (tester) async {
      // Arrange
      final container = ProviderContainer();
      container.read(currentProcessTypeProvider.notifier).value = 2;

      // Add some history data
      await container.read(
        sensorStreamProvider(const Duration(milliseconds: 50)).future,
      );
      await Future<void>.delayed(const Duration(milliseconds: 200));

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UncontrolledProviderScope(
              container: container,
              child: const HistoryChart(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Assert
      expect(
        find.text(parameters[3].displayName),
        findsAtLeastNWidgets(1),
      );
      expect(
        find.text(parameters[4].displayName),
        findsAtLeastNWidgets(1),
      );
      expect(
        find.text(parameters[5].displayName),
        findsAtLeastNWidgets(1),
      );

      container.dispose();
    });

    testWidgets('should display labels for process type 3', (tester) async {
      // Arrange
      final container = ProviderContainer();
      container.read(currentProcessTypeProvider.notifier).value = 3;

      // Add some history data
      await container.read(
        sensorStreamProvider(const Duration(milliseconds: 50)).future,
      );
      await Future<void>.delayed(const Duration(milliseconds: 200));

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UncontrolledProviderScope(
              container: container,
              child: const HistoryChart(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Assert
      expect(
        find.text(parameters[6].displayName),
        findsAtLeastNWidgets(1),
      );
      expect(
        find.text(parameters[7].displayName),
        findsAtLeastNWidgets(1),
      );
      expect(
        find.text(parameters[8].displayName),
        findsAtLeastNWidgets(1),
      );

      container.dispose();
    });

    testWidgets('should display default labels when process type is null', (
      tester,
    ) async {
      // Arrange
      final container = ProviderContainer();
      container.read(currentProcessTypeProvider.notifier).value = null;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UncontrolledProviderScope(
              container: container,
              child: const HistoryChart(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Assert - should show default labels
      expect(find.text('Label 1'), findsAtLeastNWidgets(1));
      expect(find.text('Label 2'), findsAtLeastNWidgets(1));
      expect(find.text('Label 3'), findsAtLeastNWidgets(1));

      container.dispose();
    });

    testWidgets('should render LineChart', (tester) async {
      // Arrange
      final container = ProviderContainer();
      container.read(currentProcessTypeProvider.notifier).value = 1;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UncontrolledProviderScope(
              container: container,
              child: const HistoryChart(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(HistoryChart), findsOneWidget);
      // LineChart is from fl_chart package, we just verify the widget renders
      expect(find.byType(Column), findsWidgets);

      container.dispose();
    });

    testWidgets('should update when process type changes', (tester) async {
      // Arrange
      final container = ProviderContainer();
      container.read(currentProcessTypeProvider.notifier).value = 1;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UncontrolledProviderScope(
              container: container,
              child: const HistoryChart(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Change process type
      container.read(currentProcessTypeProvider.notifier).value = 2;
      await tester.pumpAndSettle();

      // Assert
      expect(
        find.text(parameters[3].displayName),
        findsAtLeastNWidgets(1),
      );

      container.dispose();
    });
  });
}
