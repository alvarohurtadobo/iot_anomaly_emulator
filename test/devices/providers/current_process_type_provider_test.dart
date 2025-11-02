import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_anomaly_emulator/devices/providers/current_process_type_provider.dart';

void main() {
  group('CurrentProcessType', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is null', () {
      // Act
      final state = container.read(currentProcessTypeProvider);

      // Assert
      expect(state, isNull);
    });

    test('can set value to vibration process', () {
      // Act
      container.read(currentProcessTypeProvider.notifier).value = 1;

      // Assert
      expect(container.read(currentProcessTypeProvider), equals(1));
    });

    test('can set value to oil process', () {
      // Act
      container.read(currentProcessTypeProvider.notifier).value = 2;

      // Assert
      expect(container.read(currentProcessTypeProvider), equals(2));
    });

    test('can set value to hours operated process', () {
      // Act
      container.read(currentProcessTypeProvider.notifier).value = 3;

      // Assert
      expect(container.read(currentProcessTypeProvider), equals(3));
    });

    test('can update value multiple times', () {
      // Act
      container.read(currentProcessTypeProvider.notifier).value = 1;
      container.read(currentProcessTypeProvider.notifier).value = 2;
      container.read(currentProcessTypeProvider.notifier).value = 3;

      // Assert
      expect(container.read(currentProcessTypeProvider), equals(3));
    });

    test('can set value to null', () {
      // Arrange
      container.read(currentProcessTypeProvider.notifier).value = 1;

      // Act
      container.read(currentProcessTypeProvider.notifier).value = null;

      // Assert
      expect(container.read(currentProcessTypeProvider), isNull);
    });

    test('can clear value', () {
      // Arrange
      container.read(currentProcessTypeProvider.notifier).value = 1;

      // Act
      container.read(currentProcessTypeProvider.notifier).clear();

      // Assert
      expect(container.read(currentProcessTypeProvider), isNull);
    });

    test('value getter returns current state', () {
      // Arrange
      container.read(currentProcessTypeProvider.notifier).value = 2;

      // Act
      final value = container.read(currentProcessTypeProvider.notifier).value;

      // Assert
      expect(value, equals(2));
    });

    test('notifier can listen to changes', () {
      // Arrange
      final receivedValues = <int?>[];
      container.listen(
        currentProcessTypeProvider,
        (previous, next) {
          receivedValues.add(next);
        },
        fireImmediately: true,
      );

      // Act
      container.read(currentProcessTypeProvider.notifier).value = 1;

      // Assert
      expect(receivedValues.length, equals(2));
      expect(receivedValues[0], isNull);
      expect(receivedValues[1], equals(1));
    });
  });
}
