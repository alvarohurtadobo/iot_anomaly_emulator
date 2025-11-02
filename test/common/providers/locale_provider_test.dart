import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_anomaly_emulator/common/providers/locale_provider.dart';

void main() {
  group('localeProvider', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('should have default locale of en', () {
      // Arrange & Act
      final locale = container.read(localeProvider);

      // Assert
      expect(locale, equals(const Locale('en')));
    });

    test('should update locale correctly', () {
      // Arrange
      const newLocale = Locale('es');

      // Act
      container.read(localeProvider.notifier).state = newLocale;

      // Assert
      expect(container.read(localeProvider), equals(newLocale));
    });

    test('should allow setting locale to null', () {
      // Arrange
      container.read(localeProvider.notifier).state = const Locale('es');

      // Act
      container.read(localeProvider.notifier).state = null;

      // Assert
      expect(container.read(localeProvider), isNull);
    });

    test('should preserve locale across multiple reads', () {
      // Arrange
      const testLocale = Locale('fr');
      container.read(localeProvider.notifier).state = testLocale;

      // Act
      final locale1 = container.read(localeProvider);
      final locale2 = container.read(localeProvider);

      // Assert
      expect(locale1, equals(testLocale));
      expect(locale2, equals(testLocale));
    });

    test('should handle multiple locale changes', () {
      // Arrange
      final locales = [
        const Locale('en'),
        const Locale('es'),
        const Locale('fr'),
        const Locale('de'),
      ];

      // Act & Assert
      for (final locale in locales) {
        container.read(localeProvider.notifier).state = locale;
        expect(container.read(localeProvider), equals(locale));
      }
    });
  });
}
