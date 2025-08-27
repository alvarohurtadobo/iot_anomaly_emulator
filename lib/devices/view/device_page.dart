import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_anomaly_emulator/common/constants/sizes.dart';
import 'package:iot_anomaly_emulator/common/view/drawer.dart';
import 'package:iot_anomaly_emulator/devices/model/device.dart';
import 'package:iot_anomaly_emulator/devices/model/parameters.dart';
import 'package:iot_anomaly_emulator/devices/model/process_types.dart';
import 'package:iot_anomaly_emulator/devices/providers/sensor_history_provider.dart';
import 'package:iot_anomaly_emulator/devices/providers/sensor_stream_provider.dart';
import 'package:iot_anomaly_emulator/devices/view/widgets/history_chart.dart';
import 'package:iot_anomaly_emulator/devices/view/widgets/numeric_tile.dart';
import 'package:iot_anomaly_emulator/devices/view/widgets/option_tile.dart';
import 'package:iot_anomaly_emulator/l10n/l10n.dart';

class DevicePage extends ConsumerWidget {
  const DevicePage({required this.deviceId, super.key});
  final int deviceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final device = emulatedDevices.firstWhere((e) => e.id == deviceId);
    final history = ref.watch(sensorHistoryProvider);
    final sensorData = ref.watch(
      sensorStreamProvider(const Duration(seconds: 1)),
    );

    return Scaffold(
      appBar: AppBar(title: Text('Device $deviceId')),
      drawer: myDrawer(context),
      body: Column(
        children: [
          gapH8,
          OptionTile(
            title: 'Process type',
            optionsWithId: processTypesWithId,
          ),
          gapH8,
          const Text('Parameters:'),
          gapH8,
          Column(
            children: parameters
                .map<Widget>(
                  (param) => NumericTile(
                    title: param.displayName,
                    value: sensorData.value?.values[param.name],
                  ),
                )
                .toList(),
          ),
          gapH8,
          const HistoryChart(),
        ],
      ),
    );
  }
}
