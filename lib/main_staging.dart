import 'package:flutter/widgets.dart';
import 'package:iot_anomaly_emulator/app/app.dart';
import 'package:iot_anomaly_emulator/bootstrap.dart';

void main() {
  bootstrap(() async => const App() as Widget);
}
