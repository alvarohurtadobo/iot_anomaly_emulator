import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:iot_anomaly_emulator/common/routes.dart';

void main() {
  group('router', () {
    test('should be instance of GoRouter', () {
      // Assert
      expect(router, isA<GoRouter>());
    });

    test('should have routes configured', () {
      // Assert
      expect(router.configuration.routes, isNotEmpty);
    });

    test('should have shell route as root', () {
      // Assert
      final routes = router.configuration.routes;
      expect(routes, isNotEmpty);
      expect(routes.first, isA<ShellRoute>());
    });

    test('should have home route at /', () {
      // Arrange
      final shellRoute = router.configuration.routes.first as ShellRoute;
      final routes = shellRoute.routes;

      // Act
      final homeRoute =
          routes.firstWhere(
                (route) => (route as GoRoute).path == '/',
              )
              as GoRoute;

      // Assert
      expect(homeRoute, isA<GoRoute>());
      expect(homeRoute.path, equals('/'));
    });

    test('should have devices route at /devices', () {
      // Arrange
      final shellRoute = router.configuration.routes.first as ShellRoute;
      final routes = shellRoute.routes;

      // Act
      final devicesRoute =
          routes.firstWhere(
                (route) => (route as GoRoute).path == '/devices',
              )
              as GoRoute;

      // Assert
      expect(devicesRoute, isA<GoRoute>());
      expect(devicesRoute.path, equals('/devices'));
    });

    test('should have device detail route at /device/:id', () {
      // Arrange
      final shellRoute = router.configuration.routes.first as ShellRoute;
      final routes = shellRoute.routes;

      // Act
      final deviceRoute =
          routes.firstWhere(
                (route) => (route as GoRoute).path == '/device/:id',
              )
              as GoRoute;

      // Assert
      expect(deviceRoute, isA<GoRoute>());
      expect(deviceRoute.path, equals('/device/:id'));
    });

    test('should have settings route at /settings', () {
      // Arrange
      final shellRoute = router.configuration.routes.first as ShellRoute;
      final routes = shellRoute.routes;

      // Act
      final settingsRoute =
          routes.firstWhere(
                (route) => (route as GoRoute).path == '/settings',
              )
              as GoRoute;

      // Assert
      expect(settingsRoute, isA<GoRoute>());
      expect(settingsRoute.path, equals('/settings'));
    });

    test('should have all expected routes', () {
      // Arrange
      final shellRoute = router.configuration.routes.first as ShellRoute;
      final routes = shellRoute.routes;

      // Assert
      expect(routes.length, equals(4));
      expect(
        routes.map((r) => (r as GoRoute).path).toList(),
        containsAll([
          '/',
          '/devices',
          '/device/:id',
          '/settings',
        ]),
      );
    });
  });
}
