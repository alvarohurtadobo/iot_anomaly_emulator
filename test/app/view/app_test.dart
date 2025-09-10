import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_anomaly_emulator/devices/providers/sensor_stream_provider.dart';
import 'package:iot_anomaly_emulator/home/repository/mqtt_core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

// Mock del cliente MQTT
class MockMqttClient extends Mock implements MqttServerClient {}

void main() {
  group('MQTTController', () {
    late MockMqttClient mockClient;
    late MQTTController controller;

    setUp(() {
      mockClient = MockMqttClient();
      controller = MQTTController();
      controller.myClient = mockClient;
    });

    test('sendMessage publica en el topic correcto', () {
      const topic = 'flutter/sensors';
      final payload = {'device': 'Samsung A35', 'temperature': 25.0};

      when(() => mockClient.publishMessage(any(), any(), any())).thenReturn(1);

      controller.sendMessage(topic, payload);

      verify(
        () => mockClient.publishMessage(
          topic,
          MqttQos.atLeastOnce,
          any(that: isNotNull),
        ),
      ).called(1);
    });
  });

  group('sensorStreamProvider', () {
    test('emite datos con valores no vacíos', () async {
      final container = ProviderContainer();
      final stream = container.read(
        sensorStreamProvider(const Duration(milliseconds: 100)).stream,
      );

      final data = await stream.first;

      expect(data, isA<SensorData>());
      expect(data.values, isNotEmpty);
      expect(data.timestamp, isA<DateTime>());
    });
  });
}
