import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:iot_anomaly_emulator/devices/model/types.dart';
import 'package:iot_anomaly_emulator/devices/providers/current_process_type_provider.dart';
import 'package:iot_anomaly_emulator/devices/view/widgets/device_button.dart';
import 'package:iot_anomaly_emulator/l10n/l10n.dart';

void main() {
  group('DeviceButton', () {
    testWidgets('should render device name', (tester) async {
      // Arrange
      const deviceButton = DeviceButton(
        id: 1,
        name: 'Test Device',
        type: DeviceTypes.imm,
        processTypeId: 1,
        state: true,
      );

      // Act
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: GoRouter(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const Scaffold(
                  body: deviceButton,
                ),
              ),
              GoRoute(
                path: '/device/:id',
                builder: (context, state) => const Scaffold(
                  body: Text('Device Page'),
                ),
              ),
            ],
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      // Assert
      expect(find.text('Test Device'), findsOneWidget);
    });

    testWidgets('should show green border when state is true', (tester) async {
      // Arrange
      const deviceButton = DeviceButton(
        id: 1,
        name: 'Test Device',
        type: DeviceTypes.imm,
        processTypeId: 1,
        state: true,
      );

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProviderScope(
              child: deviceButton,
            ),
          ),
        ),
      );

      // Assert
      final container = tester.widget<Container>(
        find.byType(Container).first,
      );
      final decoration = container.decoration! as BoxDecoration;
      final border = decoration.border! as Border;
      expect(border.top.color, equals(Colors.green));
    });

    testWidgets('should show red border when state is false', (tester) async {
      // Arrange
      const deviceButton = DeviceButton(
        id: 1,
        name: 'Test Device',
        type: DeviceTypes.imm,
        processTypeId: 1,
        state: false,
      );

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProviderScope(
              child: deviceButton,
            ),
          ),
        ),
      );

      // Assert
      final container = tester.widget<Container>(
        find.byType(Container).first,
      );
      final decoration = container.decoration! as BoxDecoration;
      final border = decoration.border! as Border;
      expect(border.top.color, equals(Colors.red));
    });

    testWidgets('should navigate to device page on tap', (tester) async {
      // Arrange
      const deviceButton = DeviceButton(
        id: 1,
        name: 'Test Device',
        type: DeviceTypes.imm,
        processTypeId: 1,
        state: true,
      );

      // Act
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: '/',
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const Scaffold(
                  body: ProviderScope(child: deviceButton),
                ),
              ),
              GoRoute(
                path: '/device/:id',
                builder: (context, state) => Scaffold(
                  body: Text('Device ${state.pathParameters['id']}'),
                ),
              ),
            ],
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      await tester.tap(find.byType(DeviceButton));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Device 1'), findsOneWidget);
    });

    testWidgets('should update process type provider on tap', (tester) async {
      // Arrange
      const deviceButton = DeviceButton(
        id: 1,
        name: 'Test Device',
        type: DeviceTypes.imm,
        processTypeId: 2,
        state: true,
      );

      final container = ProviderContainer();

      // Act
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: GoRouter(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => Scaffold(
                  body: UncontrolledProviderScope(
                    container: container,
                    child: deviceButton,
                  ),
                ),
              ),
              GoRoute(
                path: '/device/:id',
                builder: (context, state) => const Scaffold(
                  body: Text('Device Page'),
                ),
              ),
            ],
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      await tester.tap(find.byType(DeviceButton));
      await tester.pumpAndSettle();

      // Assert
      expect(
        container.read(currentProcessTypeProvider),
        equals(2),
      );

      container.dispose();
    });

    testWidgets('should use correct image for imm type', (tester) async {
      // Arrange
      const deviceButton = DeviceButton(
        id: 1,
        name: 'Test Device',
        type: DeviceTypes.imm,
        processTypeId: 1,
        state: true,
      );

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProviderScope(
              child: deviceButton,
            ),
          ),
        ),
      );

      // Assert
      final container = tester.widget<Container>(
        find.byType(Container).first,
      );
      final decoration = container.decoration! as BoxDecoration;
      final image = decoration.image!;
      expect(image.image, isA<AssetImage>());
      final assetImage = image.image as AssetImage;
      expect(assetImage.assetName, equals('assets/images/imm.jpg'));
    });

    testWidgets('should use correct image for arc type', (tester) async {
      // Arrange
      const deviceButton = DeviceButton(
        id: 1,
        name: 'Test Device',
        type: DeviceTypes.arc,
        processTypeId: 1,
        state: true,
      );

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProviderScope(
              child: deviceButton,
            ),
          ),
        ),
      );

      // Assert
      final container = tester.widget<Container>(
        find.byType(Container).first,
      );
      final decoration = container.decoration! as BoxDecoration;
      final image = decoration.image!;
      expect(image.image, isA<AssetImage>());
      final assetImage = image.image as AssetImage;
      expect(assetImage.assetName, equals('assets/images/arc.jpg'));
    });

    testWidgets('should use correct image for other type', (tester) async {
      // Arrange
      const deviceButton = DeviceButton(
        id: 1,
        name: 'Test Device',
        type: DeviceTypes.other,
        processTypeId: 1,
        state: true,
      );

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProviderScope(
              child: deviceButton,
            ),
          ),
        ),
      );

      // Assert
      final container = tester.widget<Container>(
        find.byType(Container).first,
      );
      final decoration = container.decoration! as BoxDecoration;
      final image = decoration.image!;
      expect(image.image, isA<AssetImage>());
      final assetImage = image.image as AssetImage;
      expect(assetImage.assetName, equals('assets/images/other.jpg'));
    });
  });
}
