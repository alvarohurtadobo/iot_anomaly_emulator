import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_anomaly_emulator/home/repository/mqtt_core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

// Mock del cliente MQTT
class MockMqttClient extends Mock implements MqttServerClient {}

void main() {
  late MockMqttClient mockClient;
  late MQTTController controller;

  setUpAll(() {
    // Registrar fallback values necesarios para mocktail
    registerFallbackValue(MqttQos.atLeastOnce);
    // Registrar Uint8List que es el tipo base de Uint8Buffer
    registerFallbackValue(Uint8List(0));
  });

  setUp(() {
    mockClient = MockMqttClient();
    controller = MQTTController()..myClient = mockClient;
  });

  group('MQTTController', () {
    group('sendMessage', () {
      test('publishes message with correct topic and payload', () {
        // Arrange
        const topic = 'flutter/sensors';
        final payload = {
          'device': 'Samsung A35',
          'temperature': 25.0,
        };

        // Stub necesario porque publishMessage retorna int
        when(
          () => mockClient.publishMessage(
            any(that: equals(topic)),
            any(that: equals(MqttQos.atLeastOnce)),
            captureAny(),
          ),
        ).thenReturn(1);

        // Act
        controller.sendMessage(topic, payload);

        // Assert - verify call and capture payload
        final captured =
            verify(
                  () => mockClient.publishMessage(
                    topic,
                    MqttQos.atLeastOnce,
                    captureAny(),
                  ),
                ).captured.first
                as List<int>;

        expect(captured, isNotNull);

        // Verify payload contains expected data
        final decodedPayload = jsonDecode(utf8.decode(captured)) as Map;
        expect(decodedPayload['device'], equals('Samsung A35'));
        expect(decodedPayload['temperature'], equals(25.0));
      });

      test('publishes message with complex payload', () {
        // Arrange
        const topic = 'iot/devices/sensor1';
        final payload = {
          'device': 'Raspberry Pi 4',
          'temperature': 26.4,
          'humidity': 51.2,
          'timestamp': '2024-01-01T12:00:00Z',
          'metadata': {
            'location': 'Room 101',
            'status': 'active',
          },
        };

        when(
          () => mockClient.publishMessage(
            any(that: equals(topic)),
            any(that: equals(MqttQos.atLeastOnce)),
            captureAny(),
          ),
        ).thenReturn(1);

        // Act
        controller.sendMessage(topic, payload);

        // Assert
        verify(
          () => mockClient.publishMessage(
            topic,
            MqttQos.atLeastOnce,
            captureAny(),
          ),
        ).called(1);
      });

      test('handles empty payload correctly', () {
        // Arrange
        const topic = 'test/topic';
        final payload = <String, dynamic>{};

        when(
          () => mockClient.publishMessage(
            any(that: equals(topic)),
            any(that: equals(MqttQos.atLeastOnce)),
            captureAny(),
          ),
        ).thenReturn(1);

        // Act
        controller.sendMessage(topic, payload);

        // Assert
        verify(
          () => mockClient.publishMessage(
            topic,
            MqttQos.atLeastOnce,
            captureAny(),
          ),
        ).called(1);
      });

      test('uses atLeastOnce QoS level', () {
        // Arrange
        const topic = 'test/topic';
        final payload = {'key': 'value'};

        when(
          () => mockClient.publishMessage(
            any(that: equals(topic)),
            any(that: equals(MqttQos.atLeastOnce)),
            any(),
          ),
        ).thenReturn(1);

        // Act
        controller.sendMessage(topic, payload);

        // Assert - verify QoS is atLeastOnce
        verify(
          () => mockClient.publishMessage(
            topic,
            MqttQos.atLeastOnce,
            any(),
          ),
        ).called(1);
      });
    });

    group('disconnect', () {
      test('calls disconnect on client', () {
        // Arrange - stub necesario para métodos void
        when(() => mockClient.disconnect()).thenReturn(null);

        // Act
        controller.disconnect();

        // Assert
        verify(() => mockClient.disconnect()).called(1);
      });
    });
  });
}
