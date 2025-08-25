import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_anomaly_emulator/common/view/drawer.dart';
import 'package:iot_anomaly_emulator/devices/model/device.dart';
import 'package:iot_anomaly_emulator/devices/view/widgets/device_button.dart';
import 'package:iot_anomaly_emulator/home/providers/counter_provider.dart';
import 'package:iot_anomaly_emulator/l10n/l10n.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CounterView();
  }
}

class CounterView extends ConsumerWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.home)),
      drawer: myDrawer(context),
      body: const Center(child: DevicesWrappedList()),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => ref.read(counterProvider.notifier).increment(),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

class DevicesWrappedList extends StatelessWidget {
  const DevicesWrappedList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      children: emulatedDevices
          .map(
            (dev) => DeviceButton(
              id: dev.id,
              name: dev.name,
              type: dev.type,
            ),
          )
          .toList(),
    );
  }
}
