import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MQTTController {
  late MqttServerClient myClient;
  Future<void> init() async {
    // myClient = MqttServerClient()
    myClient =
        MqttServerClient.withPort(
            'broker.emqx.io',
            'flutter_client',
            1883,
          )
          ..keepAlivePeriod = 60
          ..logging(on: true)
          ..onConnected = () {
            debugPrint('Successfully connected');
          }
          ..onDisconnected = () {
            debugPrint('Successfully disconnected');
          }
          ..onSubscribed = (topic) {
            debugPrint('Successfully subscribed to $topic');
          };

    await myClient.connect().catchError((e) {
      debugPrint('Error: $e');
      myClient.disconnect();
      return MqttClientConnectionStatus()..disconnectionOrigin;
    });
  }

  // void sendMessage() {
  //   const pubTopic = 'flutter/sensors';
  //   final payload = {
  //     'device': 'Samsung A35',
  //     'temperature': 26.4,
  //     'humidity': 51.2,
  //     'timestamp': DateTime.now().toIso8601String(),
  //   };
  //   final builder = MqttClientPayloadBuilder();
  //   builder.addString(jsonEncode(payload));

  //   myClient.publishMessage(pubTopic, MqttQos.atLeastOnce, builder.payload!);

  //   // await Future.delayed(Duration(seconds: 5));
  // }

  void sendMessage(String topic, Map<String, dynamic> payload) {
    final builder = MqttClientPayloadBuilder()
    ..addString(jsonEncode(payload));
    myClient.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
  }

  void disconnect() {
    myClient.disconnect();
  }
}
