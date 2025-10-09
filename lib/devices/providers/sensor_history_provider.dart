import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_anomaly_emulator/devices/providers/current_process_type_provider.dart';
import 'package:iot_anomaly_emulator/devices/providers/sensor_stream_provider.dart';

final sensorHistoryProvider =
    NotifierProvider<SensorHistoryNotifier, List<SensorData>>(
      SensorHistoryNotifier.new,
    );

class SensorHistoryNotifier extends Notifier<List<SensorData>> {
  static const int maxLength = 32;
  StreamSubscription<SensorData>? _sub;

  @override
  List<SensorData> build() {
    // Initial empty state
    state = [];

    // Listen to sensor data
    // final processType =
    ref.watch(currentProcessTypeProvider);
    final stream = ref.watch(
      sensorStreamProvider(const Duration(seconds: 1)).stream,
    );

    _sub?.cancel();
    _sub = stream.listen((data) {
      // Append new data and delete outside of 64 elements window
      final updated = [...state, data];
      if (updated.length >= maxLength) {
        state = updated.sublist(updated.length - (maxLength - 1));
      } else {
        state = updated;
      }
      debugPrint('Historic data len: ${updated.length}');
    });

    ref.onDispose(() => _sub?.cancel());
    return state;
  }
}
