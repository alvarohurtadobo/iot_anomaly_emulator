import 'dart:core';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_anomaly_emulator/devices/model/device.dart';

StreamProviderFamily<List<EmulatedDevice>, Duration> stateStreamProvider =
    StreamProvider.family<List<EmulatedDevice>, Duration>((ref, interval) {
      final random = Random(DateTime.now().millisecondsSinceEpoch);

      return Stream.periodic(interval, (_) {
        return emulatedDevices
            .map((device) => device.copyWith(state: random.nextBool()))
            .toList();
      });
    });
