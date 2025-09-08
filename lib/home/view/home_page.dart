import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_anomaly_emulator/devices/providers/state_stream_provider.dart';
import 'package:iot_anomaly_emulator/devices/view/widgets/device_button.dart';
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
    return const Scaffold(
      body: Center(child: Text('Welcome to IoT emulator')),
      // floatingActionButton: Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   crossAxisAlignment: CrossAxisAlignment.end,
      //   children: [
      //     FloatingActionButton(
      //       onPressed: () {},
      //       child: const Icon(Icons.add),
      //     ),
      //   ],
      // ),
    );
  }
}
