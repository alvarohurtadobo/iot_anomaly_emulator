import 'dart:convert';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MQTTConttoller {
  late MqttServerClient myClient;
  Future<void> init() async {
    myClient =
        MqttServerClient.withPort(
            'broker.emqx.io',
            'flutter_client',
            1883,
          )
          ..keepAlivePeriod = 60
          ..logging(on: true)
          ..onConnected = () {
            print('Successfully connected');
          }
          ..onDisconnected = () {
            print('Successfully disconnected');
          }
          ..onSubscribed = (topic) {
            print('Successfully subscribed to $topic');
          };

    try {
      await myClient.connect();
    } catch (e) {
      print('Error: $e');
      myClient.disconnect();
    }
  }

  sendMessage() {
    const pubTopic = 'flutter/sensors';
    final payload = {
      'device': 'Samsung A35',
      'temperature': 26.4,
      'humidity': 51.2,
      'timestamp': DateTime.now().toIso8601String(),
    };
    final builder = MqttClientPayloadBuilder();
    builder.addString(jsonEncode(payload));

    myClient.publishMessage(pubTopic, MqttQos.atLeastOnce, builder.payload!);

    // await Future.delayed(Duration(seconds: 5));
  }

  dissconnect() {
    myClient.disconnect();
  }
}
