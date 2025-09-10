import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_anomaly_emulator/common/constants/sizes.dart';
import 'package:iot_anomaly_emulator/devices/model/device.dart';
import 'package:iot_anomaly_emulator/devices/model/device_sate.dart';
import 'package:iot_anomaly_emulator/devices/model/parameters.dart';
import 'package:iot_anomaly_emulator/devices/model/process_types.dart';
import 'package:iot_anomaly_emulator/devices/providers/current_device_state.dart';
import 'package:iot_anomaly_emulator/devices/providers/current_process_type_provider.dart';
import 'package:iot_anomaly_emulator/devices/providers/sensor_history_provider.dart';
import 'package:iot_anomaly_emulator/devices/providers/sensor_stream_provider.dart';
import 'package:iot_anomaly_emulator/devices/providers/start_datetime_provider.dart';
import 'package:iot_anomaly_emulator/devices/view/widgets/history_chart.dart';
import 'package:iot_anomaly_emulator/devices/view/widgets/numeric_tile.dart';
import 'package:iot_anomaly_emulator/devices/view/widgets/option_tile.dart';
import 'package:iot_anomaly_emulator/home/providers/mqtt_controller_provider.dart';
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

    final mqttController = ref.watch(mqttControllerProvider);

    sensorData.whenData((data) {
      if (data.values.isNotEmpty) {
        mqttController.sendMessage(
          'flutter/sensors/${device.id}', // each device
          {
            'device': device.name,
            'timestamp': data.timestamp.toIso8601String(),
            ...data.values,
          },
        );
      }
    });

    return Scaffold(
      body: Column(
        children: [
          gapH8,
          OptionTile(
            title: l10n.process_type,
            optionsWithId: processTypesWithId,
            onChanged: (value) {
              ref.read(currentProcessTypeProvider.notifier).value = value;
              ref.read(currentStartDatetimeProvider.notifier).setToNow();
            },
            value: ref.watch(currentProcessTypeProvider) ?? 0,
          ),
          gapH8,
          OptionTile(
            title: l10n.device_state,
            optionsWithId: deviceStatesWithId,
            onChanged: (value) {
              ref.read(currentDeviceStateProvider.notifier).value = value;
            },
            value: ref.watch(currentDeviceStateProvider) ?? 0,
          ),
          gapH8,
          Text('${l10n.parameter}s:'),
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
