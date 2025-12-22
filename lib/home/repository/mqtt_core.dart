import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MQTTController {
  late MqttServerClient myClient;
  Future<void> init() async {
    myClient =
        MqttServerClient(
            'broker.emqx.io',
            'iot_anomaly_detector_1992',
          )
          ..port = 1883
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

    await myClient.connect().catchError((_) {
      myClient.disconnect();
      return MqttClientConnectionStatus()..disconnectionOrigin;
    });
  }

  void sendMessage(String topic, Map<String, dynamic> payload) {
    final builder = MqttClientPayloadBuilder()..addString(jsonEncode(payload));
    debugPrint('Sending data: ${jsonEncode(payload)}');
    myClient.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
  }

  void disconnect() {
    myClient.disconnect();
  }
}
