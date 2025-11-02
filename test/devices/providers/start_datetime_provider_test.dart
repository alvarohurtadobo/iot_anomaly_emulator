import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_anomaly_emulator/devices/providers/start_datetime_provider.dart';

void main() {
  group('StartDatetimeProvider', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is null', () {
      // Act
      final state = container.read(currentStartDatetimeProvider);

      // Assert
      expect(state, isNull);
    });

    test('can set value to custom datetime', () {
      // Arrange
      final testDate = DateTime(2025, 1, 1, 12, 30);

      // Act
      container.read(currentStartDatetimeProvider.notifier).value = testDate;

      // Assert
      expect(container.read(currentStartDatetimeProvider), equals(testDate));
    });

    test('can set value to now', () {
      // Arrange
      final beforeNow = DateTime.now();

      // Act
      container.read(currentStartDatetimeProvider.notifier).setToNow();
      final now = container.read(currentStartDatetimeProvider);

      // Assert
      expect(now, isNotNull);
      expect(now!.isAfter(beforeNow), isTrue);
      expect(
        now.isBefore(DateTime.now().add(const Duration(seconds: 1))),
        isTrue,
      );
    });

    test('can update value multiple times', () {
      // Arrange
      final firstDate = DateTime(2025, 1, 1);
      final secondDate = DateTime(2025, 2, 1);
      final thirdDate = DateTime(2025, 3, 1);

      // Act
      container.read(currentStartDatetimeProvider.notifier).value = firstDate;
      container.read(currentStartDatetimeProvider.notifier).value = secondDate;
      container.read(currentStartDatetimeProvider.notifier).value = thirdDate;

      // Assert
      expect(container.read(currentStartDatetimeProvider), equals(thirdDate));
    });

    test('can set value to null', () {
      // Arrange
      final testDate = DateTime(2025, 1, 1);
      container.read(currentStartDatetimeProvider.notifier).value = testDate;

      // Act
      container.read(currentStartDatetimeProvider.notifier).value = null;

      // Assert
      expect(container.read(currentStartDatetimeProvider), isNull);
    });

    test('value getter returns current state', () {
      // Arrange
      final testDate = DateTime(2025, 6, 15, 10, 0);
      container.read(currentStartDatetimeProvider.notifier).value = testDate;

      // Act
      final value = container.read(currentStartDatetimeProvider.notifier).value;

      // Assert
      expect(value, equals(testDate));
    });

    test('notifier can listen to changes', () {
      // Arrange
      final receivedValues = <DateTime?>[];
      container.listen(
        currentStartDatetimeProvider,
        (previous, next) {
          receivedValues.add(next);
        },
        fireImmediately: true,
      );
      final testDate = DateTime(2025, 1, 1);

      // Act
      container.read(currentStartDatetimeProvider.notifier).value = testDate;

      // Assert
      expect(receivedValues.length, equals(2));
      expect(receivedValues[0], isNull);
      expect(receivedValues[1], equals(testDate));
    });
  });
}
