import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_anomaly_emulator/devices/providers/currentProcessTypeProvider.dart';

class SensorData {
  SensorData(this.values) : timestamp = DateTime.now();

  final Map<String, double> values;
  final DateTime timestamp;

  @override
  String toString() => '[$timestamp] $values';
}

final _random = Random();

double normalRandom({double mean = 0, double stdDev = 0.5}) {
  // Box-Muller
  final u1 = _random.nextDouble();
  final u2 = _random.nextDouble();
  final z0 = sqrt(-2 * log(u1)) * cos(2 * pi * u2);
  return z0 * stdDev + mean;
}

double exponentialRandom({double scale = 50}) {
  final u = _random.nextDouble();
  return -scale * log(1 - u);
}

int poissonRandom({double lambda = 2}) {
  int k = 0;
  double p = 1.0;
  final L = exp(-lambda);
  do {
    k++;
    p *= _random.nextDouble();
  } while (p > L);
  return k - 1;
}

StreamProviderFamily<SensorData, Duration> sensorStreamProvider =
    StreamProvider.family<SensorData, Duration>((ref, interval) {
      final processType = ref.watch(currentProcessTypeProvider);

      return Stream.periodic(interval, (_) {
        if (processType == null) return SensorData({});

        switch (processType) {
          case 1:
            return SensorData({
              'vibration': normalRandom(mean: 10, stdDev: 2),
              'temperature': normalRandom(mean: 25, stdDev: 1),
              'pressure': exponentialRandom(scale: 30),
            });

          case 2:
            return SensorData({
              'oil_quality': normalRandom(mean: 80, stdDev: 5),
              'contaminant_level': poissonRandom(lambda: 3) * 1.0,
              'acidity': normalRandom(mean: 7, stdDev: 0.3),
            });

          case 3:
            return SensorData({
              'hours_operated': exponentialRandom(scale: 100),
              'maintenance_history': poissonRandom(lambda: 1.5) * 1.0,
              'load': normalRandom(mean: 50, stdDev: 10),
            });
          default:
            return SensorData({});
        }
      });
    });
