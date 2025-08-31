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

double uniformRandom({double min = 0, double max = 100}) {
  return min + _random.nextDouble() * (max - min);
}

StreamProviderFamily<SensorData, Duration>
sensorStreamProvider = StreamProvider.family<SensorData, Duration>((
  ref,
  interval,
) {
  final processType = ref.watch(currentProcessTypeProvider);

  final initialEmulationDatetime =
      ref.watch(currentStartDatetimeProvider) ?? DateTime(2025);

  return Stream.periodic(interval, (_) {
    final currentTimestamp = DateTime.now();
    if (processType == null) {
      return SensorData(values: {}, timestamp: currentTimestamp);
    }
    final elapsedTimeSinceStartEmulation = currentTimestamp
        .difference(initialEmulationDatetime)
        .inSeconds;
    print(
      'Initial $initialEmulationDatetime, elapsed time: $elapsedTimeSinceStartEmulation',
    );

    switch (processType) {
      case 1: // Vibrations
        final vibration =
            sin(elapsedTimeSinceStartEmulation / 5) +
            normalRandom(mean: 0.0, stdDev: 0.5);
        return SensorData(
          values: {
            'vibration': vibration,
            'temperature':
                20 + 2 * vibration + normalRandom(mean: 0, stdDev: 0.5),
            'pressure':
                30 +
                3 * vibration * vibration +
                normalRandom(mean: 0, stdDev: 1),
          },
          timestamp: currentTimestamp,
        );

      case 2: // Oil Analysis
        final oilQuality =
            uniformRandom(min: 0, max: 100) +
            elapsedTimeSinceStartEmulation * 0.1;
        return SensorData(
          values: {
            'oil_quality': oilQuality,
            'contaminant_level':
                50 + 0.5 * oilQuality + normalRandom(mean: 0, stdDev: 5),
            'acidity':
                10 +
                0.3 * sqrt(oilQuality * oilQuality * oilQuality) +
                normalRandom(mean: 0, stdDev: 2),
          },
          timestamp: currentTimestamp,
        );

      case 3: // HoursOperated
        final hoursOperated =
            exponentialRandom(scale: 50) + elapsedTimeSinceStartEmulation * 0.5;
        return SensorData(
          values: {
            'hours_operated': hoursOperated,
            'maintenance_history': poissonRandom(lambda: 2) * 1.0,
            'load':
                100 +
                0.1 * elapsedTimeSinceStartEmulation +
                normalRandom(mean: 0, stdDev: 10),
          },
          timestamp: currentTimestamp,
        );
      default:
        return SensorData(values: {}, timestamp: currentTimestamp);
    }
  });
});
