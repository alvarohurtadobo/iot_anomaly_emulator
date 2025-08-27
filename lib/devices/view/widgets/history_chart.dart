import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_anomaly_emulator/common/constants/sizes.dart';
import 'package:iot_anomaly_emulator/devices/providers/sensor_history_provider.dart';

class HistoryChart extends ConsumerWidget {
  const HistoryChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(sensorHistoryProvider);

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.p12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Temperature',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Vibration',
                style: TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Pressure',
                style: TextStyle(
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
                        history[i].values['temperature'] ?? 0,
                      ),
                  ],
                ),
                LineChartBarData(
                  color: Colors.yellow,
                  spots: [
                    for (int i = 0; i < history.length; i++)
                      FlSpot(
                        i.toDouble(),
                        history[i].values['vibration'] ?? 0,
                      ),
                  ],
                ),
                LineChartBarData(
                  color: Colors.blue,
                  spots: [
                    for (int i = 0; i < history.length; i++)
                      FlSpot(
                        i.toDouble(),
                        history[i].values['pressure'] ?? 0,
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
