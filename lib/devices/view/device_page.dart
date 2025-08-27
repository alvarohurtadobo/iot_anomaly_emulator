import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_anomaly_emulator/common/view/drawer.dart';
import 'package:iot_anomaly_emulator/devices/model/device.dart';
import 'package:iot_anomaly_emulator/devices/model/process_types.dart';
import 'package:iot_anomaly_emulator/devices/view/widgets/option_tile.dart';
import 'package:iot_anomaly_emulator/l10n/l10n.dart';

class DevicePage extends ConsumerWidget {
  const DevicePage({required this.deviceId, super.key});
  final int deviceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final device = emulatedDevices.firstWhere((e) => e.id == deviceId);
    return Scaffold(
      appBar: AppBar(title: Text('${l10n.devices} $deviceId')),
      drawer: myDrawer(context),
      body: Column(
        children: [
          Center(child: Text('Device ${device.id}')),
          Center(
            child: Text(
              'Process type ${processTypeToString(device.processType)}',
            ),
          ),
          OptionTile(
            title: 'Process type',
            optionsWithId: processTypeWithId,
          ),
        ],
      ),
    );
  }
}
