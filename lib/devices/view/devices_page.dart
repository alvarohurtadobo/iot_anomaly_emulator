import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_anomaly_emulator/devices/providers/state_stream_provider.dart';
import 'package:iot_anomaly_emulator/devices/view/widgets/device_button.dart';

class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DevicesWrappedList();
  }
}

class DevicesWrappedList extends ConsumerWidget {
  const DevicesWrappedList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final emulatedDevices = ref
        .watch(
          stateStreamProvider(const Duration(seconds: 1)),
        )
        .value;

    if (emulatedDevices == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      children: emulatedDevices
          .map(
            (dev) => DeviceButton(
              id: dev.id,
              name: dev.name,
              type: dev.type,
              processTypeId: dev.processType.id,
              state: dev.state,
            ),
          )
          .toList(),
    );
  }
}
