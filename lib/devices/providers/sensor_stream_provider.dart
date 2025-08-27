import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_anomaly_emulator/devices/providers/current_process_type_provider.dart';
import 'package:iot_anomaly_emulator/devices/providers/start_datetime_provider.dart';

class SensorData {
  SensorData({required this.values, required this.timestamp});

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
      final currentTimestamp = DateTime.now();
      final initialEmulationDatetime =
          ref.watch(currentStartDatetimeProvider) ?? DateTime(2025, 1, 1);

      return Stream.periodic(interval, (_) {
        if (processType == null) {
          return SensorData(values: {}, timestamp: currentTimestamp);
        }

        int elapsedTimeSinceStartEmulation = currentTimestamp
            .difference(initialEmulationDatetime)
            .inSeconds;

        switch (processType) {
          case 1:
            return SensorData(
              values: {
                'vibration':
                    sin(elapsedTimeSinceStartEmulation / 5) +
                    normalRandom(mean: 0.0, stdDev: 0.5),
                'temperature': normalRandom(mean: 25, stdDev: 1),
                'pressure': exponentialRandom(scale: 30),
              },
              timestamp: currentTimestamp,
            );

          case 2:
            return SensorData(
              values: {
                'oil_quality': normalRandom(mean: 80, stdDev: 5),
                'contaminant_level': poissonRandom(lambda: 3) * 1.0,
                'acidity': normalRandom(mean: 7, stdDev: 0.3),
              },
              timestamp: currentTimestamp,
            );

          case 3:
            return SensorData(
              values: {
                'hours_operated': exponentialRandom(scale: 100),
                'maintenance_history': poissonRandom(lambda: 1.5) * 1.0,
                'load': normalRandom(mean: 50, stdDev: 10),
              },
              timestamp: currentTimestamp,
            );
          default:
            return SensorData(values: {}, timestamp: currentTimestamp);
        }
      });
    });
