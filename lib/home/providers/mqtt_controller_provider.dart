import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_anomaly_emulator/home/repository/mqtt_core.dart';

final mqttControllerProvider = Provider<MQTTController>((ref) {
  final controller = MQTTController()..init();
  ref.onDispose(controller.disconnect);
  return controller;
});
