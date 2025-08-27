import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_anomaly_emulator/common/constants/sizes.dart';
import 'package:iot_anomaly_emulator/devices/model/parameters.dart';
import 'package:iot_anomaly_emulator/devices/model/process_types.dart';
import 'package:iot_anomaly_emulator/devices/providers/current_process_type_provider.dart';
import 'package:iot_anomaly_emulator/devices/providers/sensor_history_provider.dart';

class HistoryChart extends ConsumerWidget {
  const HistoryChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(sensorHistoryProvider);

    final processTypeId = ref.watch(currentProcessTypeProvider);

    final processType = processTypesWithId.firstWhere(
      (pType) => pType.id == processTypeId,
    );

    var label1 = 'Label 1';
    var label2 = 'Label 2';
    var label3 = 'Label 3';
    var key1 = 'key1';
    var key2 = 'key2';
    var key3 = 'key3';

    if (processTypeId == 1) {
      label1 = parameters[0].displayName;
      label2 = parameters[1].displayName;
      label3 = parameters[2].displayName;
      key1 = parameters[0].name;
      key2 = parameters[1].name;
      key3 = parameters[2].name;
    } else if (processTypeId == 2) {
      label1 = parameters[3].displayName;
      label2 = parameters[4].displayName;
      label3 = parameters[5].displayName;
      key1 = parameters[3].name;
      key2 = parameters[4].name;
      key3 = parameters[5].name;
    } else if (processTypeId == 3) {
      label1 = parameters[6].displayName;
      label2 = parameters[7].displayName;
      label3 = parameters[8].displayName;
      key1 = parameters[6].name;
      key2 = parameters[7].name;
      key3 = parameters[8].name;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.p12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label1,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label2,
                style: const TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label3,
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 400,
          height: 320,
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  color: Colors.red,
                  spots: [
                    for (int i = 0; i < history.length; i++)
                      FlSpot(
                        i.toDouble(),
                        history[i].values[key1] ?? 0,
                      ),
                  ],
                ),
                LineChartBarData(
                  color: Colors.yellow,
                  spots: [
                    for (int i = 0; i < history.length; i++)
                      FlSpot(
                        i.toDouble(),
                        history[i].values[key2] ?? 0,
                      ),
                  ],
                ),
                LineChartBarData(
                  color: Colors.blue,
                  spots: [
                    for (int i = 0; i < history.length; i++)
                      FlSpot(
                        i.toDouble(),
                        history[i].values[key3] ?? 0,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
