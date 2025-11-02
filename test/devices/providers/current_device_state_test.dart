import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_anomaly_emulator/devices/providers/current_device_state.dart';

void main() {
  group('CurrentDeviceState', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is null', () {
      // Act
      final state = container.read(currentDeviceStateProvider);

      // Assert
      expect(state, isNull);
    });

    test('can set value', () {
      // Act
      container.read(currentDeviceStateProvider.notifier).value = 1;

      // Assert
      expect(container.read(currentDeviceStateProvider), equals(1));
    });

    test('can update value multiple times', () {
      // Act
      container.read(currentDeviceStateProvider.notifier).value = 1;
      container.read(currentDeviceStateProvider.notifier).value = 2;
      container.read(currentDeviceStateProvider.notifier).value = 0;

      // Assert
      expect(container.read(currentDeviceStateProvider), equals(0));
    });

    test('can set value to null', () {
      // Arrange
      container.read(currentDeviceStateProvider.notifier).value = 1;

      // Act
      container.read(currentDeviceStateProvider.notifier).value = null;

      // Assert
      expect(container.read(currentDeviceStateProvider), isNull);
    });

    test('can clear value', () {
      // Arrange
      container.read(currentDeviceStateProvider.notifier).value = 1;

      // Act
      container.read(currentDeviceStateProvider.notifier).clear();

      // Assert
      expect(container.read(currentDeviceStateProvider), isNull);
    });

    test('value getter returns current state', () {
      // Arrange
      container.read(currentDeviceStateProvider.notifier).value = 42;

      // Act
      final value = container.read(currentDeviceStateProvider.notifier).value;

      // Assert
      expect(value, equals(42));
    });

    test('notifier can listen to changes', () {
      // Arrange
      final receivedValues = <int?>[];
      container.listen(
        currentDeviceStateProvider,
        (previous, next) {
          receivedValues.add(next);
        },
        fireImmediately: true,
      );

      // Act
      container.read(currentDeviceStateProvider.notifier).value = 1;

      // Assert
      expect(receivedValues.length, equals(2));
      expect(receivedValues[0], isNull);
      expect(receivedValues[1], equals(1));
    });
  });
}
