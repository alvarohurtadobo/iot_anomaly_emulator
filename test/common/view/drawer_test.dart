import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_anomaly_emulator/common/view/drawer.dart';
import '../../helpers/pump_app.dart';

void main() {
  group('myDrawer', () {
    testWidgets('should render drawer with IoT Monitor header', (tester) async {
      // Arrange
      await tester.pumpApp(
        Builder(
          builder: (context) {
            return Scaffold(
              drawer: myDrawer(context),
              body: const SizedBox(),
            );
          },
        ),
      );

      // Act - Open drawer
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('IoT Monitor'), findsOneWidget);
      expect(find.byType(Drawer), findsOneWidget);
    });

    testWidgets('should render Home menu item', (tester) async {
      // Arrange
      await tester.pumpApp(
        Builder(
          builder: (context) {
            return Scaffold(
              drawer: myDrawer(context),
              body: const SizedBox(),
            );
          },
        ),
      );

      // Act - Open drawer
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('should render Devices menu item', (tester) async {
      // Arrange
      await tester.pumpApp(
        Builder(
          builder: (context) {
            return Scaffold(
              drawer: myDrawer(context),
              body: const SizedBox(),
            );
          },
        ),
      );

      // Act - Open drawer
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byIcon(Icons.hardware), findsOneWidget);
      expect(find.text('Devices'), findsOneWidget);
    });

    testWidgets('should render Settings menu item', (tester) async {
      // Arrange
      await tester.pumpApp(
        Builder(
          builder: (context) {
            return Scaffold(
              drawer: myDrawer(context),
              body: const SizedBox(),
            );
          },
        ),
      );

      // Act - Open drawer
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byIcon(Icons.settings), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('should have all menu items in correct order', (tester) async {
      // Arrange
      await tester.pumpApp(
        Builder(
          builder: (context) {
            return Scaffold(
              drawer: myDrawer(context),
              body: const SizedBox(),
            );
          },
        ),
      );

      // Act - Open drawer
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Assert
      final icons = find.byType(ListTile);
      expect(icons, findsNWidgets(3));

      // Check order: Home, Devices, Settings
      final listTiles = tester.widgetList<ListTile>(icons).toList();
      expect(listTiles[0].leading, isA<Icon>());
      expect((listTiles[0].leading as Icon).icon, equals(Icons.home));
      expect((listTiles[1].leading as Icon).icon, equals(Icons.hardware));
      expect((listTiles[2].leading as Icon).icon, equals(Icons.settings));
    });

    testWidgets('should have correct drawer header color', (tester) async {
      // Arrange
      await tester.pumpApp(
        Builder(
          builder: (context) {
            return Scaffold(
              drawer: myDrawer(context),
              body: const SizedBox(),
            );
          },
        ),
      );

      // Act - Open drawer
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Assert
      final drawerHeader = tester.widget<DrawerHeader>(
        find.byType(DrawerHeader),
      );
      expect(
        (drawerHeader.decoration as BoxDecoration).color,
        equals(Colors.blue),
      );
    });

    testWidgets('should have correct header text style', (tester) async {
      // Arrange
      await tester.pumpApp(
        Builder(
          builder: (context) {
            return Scaffold(
              drawer: myDrawer(context),
              body: const SizedBox(),
            );
          },
        ),
      );

      // Act - Open drawer
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Assert
      final headerText = tester.widget<Text>(find.text('IoT Monitor'));
      expect(headerText.style?.color, equals(Colors.white));
      expect(headerText.style?.fontSize, equals(24));
    });

    testWidgets('should close drawer when menu item is tapped', (tester) async {
      // Arrange
      await tester.pumpApp(
        Builder(
          builder: (context) {
            return Scaffold(
              drawer: myDrawer(context),
              body: const SizedBox(),
            );
          },
        ),
      );

      // Open drawer
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      expect(find.byType(Drawer), findsOneWidget);

      // Act
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();

      // Assert - drawer should be closed
      expect(find.byType(Drawer), findsNothing);
    });
  });
}
