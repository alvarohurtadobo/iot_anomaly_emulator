import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_anomaly_emulator/devices/providers/sensor_history_provider.dart';

class HistoryChart extends ConsumerWidget {
  const HistoryChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(sensorHistoryProvider);

    return SizedBox(
      width: 400,
      height: 400,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: [
                for (int i = 0; i < history.length; i++)
                  FlSpot(
                    i.toDouble(),
                    history[i].values['temperature']?.toDouble() ?? 0,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
