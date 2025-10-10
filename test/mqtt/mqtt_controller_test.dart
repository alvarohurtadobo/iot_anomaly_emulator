// import 'dart:convert';
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

  setUp(() {
    mockClient = MockMqttClient();
    controller = MQTTController()..myClient = mockClient;
  });

  test('sendMessage publish correct topic', () {
    const topic = 'flutter/sensors';
    final payload = {
      'device': 'Samsung A35',
      'temperature': 25.0,
    };

    // emulate that publishing a message returns an integer
    when(() => mockClient.publishMessage(any(), any(), any())).thenReturn(1);

    controller.sendMessage(topic, payload);

    // verify that publishMessage has been called
    // final builder =MqttClientPayloadBuilder()..addString(jsonEncode(payload));
    verify(
      () => mockClient.publishMessage(
        topic,
        MqttQos.atLeastOnce,
        any(that: isNotNull),
      ),
    ).called(1);
  });
}
