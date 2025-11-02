import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:iot_anomaly_emulator/common/main_layout.dart';
import 'package:iot_anomaly_emulator/l10n/l10n.dart';

void main() {
  group('MainLayout', () {
    testWidgets('should render NavigationRail for large screens', (
      tester,
    ) async {
      // Arrange
      const child = Text('Test Content');

      // Act
      await tester.pumpAppWithRouter(
        const MainLayout(child: child),
        '/',
      );

      // Assert
      expect(find.byType(NavigationRail), findsOneWidget);
      expect(find.byType(Drawer), findsNothing);
      expect(find.text('Test Content'), findsOneWidget);
    });

    testWidgets('should render Drawer for small screens', (tester) async {
      // Arrange
      const child = Text('Test Content');

      // Act
      await tester.pumpAppWithRouter(
        const MainLayout(child: child),
        '/',
        windowSize: const Size(600, 800),
      );

      // Assert
      expect(find.byType(NavigationRail), findsNothing);
      expect(find.byType(Drawer), findsOneWidget);
      expect(find.text('Test Content'), findsOneWidget);
    });

    testWidgets('should display AppBar for small screens', (tester) async {
      // Arrange
      const child = Text('Test Content');

      // Act
      await tester.pumpAppWithRouter(
        const MainLayout(child: child),
        '/',
        windowSize: const Size(600, 800),
      );

      // Assert
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('should not display AppBar for large screens', (tester) async {
      // Arrange
      const child = Text('Test Content');

      // Act
      await tester.pumpAppWithRouter(
        const MainLayout(child: child),
        '/',
      );

      // Assert
      expect(find.byType(AppBar), findsNothing);
    });

    testWidgets('should show correct title for home in small screen', (
      tester,
    ) async {
      // Arrange
      const child = Text('Test Content');

      // Act
      await tester.pumpAppWithRouter(
        const MainLayout(child: child),
        '/',
        windowSize: const Size(600, 800),
      );

      // Assert
      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('should show correct title for devices in small screen', (
      tester,
    ) async {
      // Arrange
      const child = Text('Test Content');

      // Act
      await tester.pumpAppWithRouter(
        const MainLayout(child: child),
        '/devices',
        windowSize: const Size(600, 800),
      );

      // Assert
      expect(find.text('Devices'), findsOneWidget);
    });

    testWidgets('should show correct title for settings in small screen', (
      tester,
    ) async {
      // Arrange
      const child = Text('Test Content');

      // Act
      await tester.pumpAppWithRouter(
        const MainLayout(child: child),
        '/settings',
        windowSize: const Size(600, 800),
      );

      // Assert
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('should have correct selected index for home', (tester) async {
      // Arrange
      const child = Text('Test Content');

      // Act
      await tester.pumpAppWithRouter(
        const MainLayout(child: child),
        '/',
      );

      // Assert
      final navigationRail = tester.widget<NavigationRail>(
        find.byType(NavigationRail),
      );
      expect(navigationRail.selectedIndex, equals(0));
    });

    testWidgets('should have correct selected index for devices', (
      tester,
    ) async {
      // Arrange
      const child = Text('Test Content');

      // Act
      await tester.pumpAppWithRouter(
        const MainLayout(child: child),
        '/devices',
      );

      // Assert
      final navigationRail = tester.widget<NavigationRail>(
        find.byType(NavigationRail),
      );
      expect(navigationRail.selectedIndex, equals(1));
    });

    testWidgets('should have correct selected index for settings', (
      tester,
    ) async {
      // Arrange
      const child = Text('Test Content');

      // Act
      await tester.pumpAppWithRouter(
        const MainLayout(child: child),
        '/settings',
      );

      // Assert
      final navigationRail = tester.widget<NavigationRail>(
        find.byType(NavigationRail),
      );
      expect(navigationRail.selectedIndex, equals(2));
    });

    testWidgets('should have all navigation destinations', (tester) async {
      // Arrange
      const child = Text('Test Content');

      // Act
      await tester.pumpAppWithRouter(
        const MainLayout(child: child),
        '/',
      );

      // Assert
      final navigationRail = tester.widget<NavigationRail>(
        find.byType(NavigationRail),
      );
      expect(navigationRail.destinations.length, equals(3));
    });

    testWidgets('should have correct icons for navigation destinations', (
      tester,
    ) async {
      // Arrange
      const child = Text('Test Content');

      // Act
      await tester.pumpAppWithRouter(
        const MainLayout(child: child),
        '/',
      );

      // Assert
      expect(find.byIcon(Icons.home), findsNWidgets(1));
      expect(find.byIcon(Icons.hardware), findsNWidgets(1));
      expect(find.byIcon(Icons.settings), findsNWidgets(1));
    });

    test('should handle child parameter correctly', () {
      // Arrange
      const child = Text('Test Child');

      // Act
      const layout = MainLayout(child: child);

      // Assert
      expect(layout.child, equals(child));
    });

    testWidgets('should have correct border case for 800px width', (
      tester,
    ) async {
      // Arrange
      const child = Text('Test Content');

      // Act - 800px should be small screen (not > 800)
      await tester.pumpAppWithRouter(
        const MainLayout(child: child),
        '/',
        windowSize: const Size(800, 800),
      );

      // Assert - should show drawer
      expect(find.byType(NavigationRail), findsNothing);
      expect(find.byType(Drawer), findsOneWidget);
    });

    testWidgets('should have correct border case for 801px width', (
      tester,
    ) async {
      // Arrange
      const child = Text('Test Content');

      // Act - 801px should be large screen (> 800)
      await tester.pumpAppWithRouter(
        const MainLayout(child: child),
        '/',
        windowSize: const Size(801, 800),
      );

      // Assert - should show navigation rail
      expect(find.byType(NavigationRail), findsOneWidget);
      expect(find.byType(Drawer), findsNothing);
    });
  });
}

// Extension to pump widget with router configuration
extension MainLayoutTest on WidgetTester {
  Future<void> pumpAppWithRouter(
    Widget widget,
    String initialLocation, {
    Size? windowSize,
  }) async {
    await pumpWidget(
      MediaQuery(
        data: MediaQueryData(
          size: windowSize ?? const Size(1200, 800),
        ),
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: initialLocation,
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => widget,
              ),
              GoRoute(
                path: '/devices',
                builder: (context, state) => widget,
              ),
              GoRoute(
                path: '/settings',
                builder: (context, state) => widget,
              ),
            ],
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
  }
}
