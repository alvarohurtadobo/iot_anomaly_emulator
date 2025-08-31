import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_anomaly_emulator/devices/model/device.dart';
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
    return Scaffold(
      body: const Center(child: DevicesWrappedList()),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

// class DevicesWrappedList extends StatefulWidget {
//   const DevicesWrappedList({super.key});

//   @override
//   State<DevicesWrappedList> createState() => DevicesWrappedListState();
// }

// class DevicesWrappedListState extends State<DevicesWrappedList> {
//   StreamController<List<EmulatedDevice>> emulatedDeviceStream =
//       StreamController<List<EmulatedDevice>>();
//   @override
//   void initState() {
//     super.initState();

//     Future<void>.delayed(const Duration(seconds: 3), () async {
//       final random = Random(DateTime.now().millisecondsSinceEpoch);

//       for (int i = 0; i < 100; i++) {
//         await Future<void>.delayed(const Duration(seconds: 2));
//         emulatedDevices = emulatedDevices
//             .map((device) => device.copyWith(state: random.nextBool()))
//             .toList();
//         emulatedDeviceStream.sink.add(emulatedDevices);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return StreamBuilder(
//       stream: emulatedDeviceStream.stream,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         if (snapshot.hasError) {
//           return const Center(
//             child: Text('Error arrived'),
//           );
//         }
//         if (snapshot.hasData) {
//           final arrivingDevices = snapshot.data!;
//           return Wrap(
//             alignment: WrapAlignment.spaceBetween,
//             children: arrivingDevices
//                 .map(
//                   (dev) => DeviceButton(
//                     id: dev.id,
//                     name: dev.name,
//                     type: dev.type,
//                     processTypeId: dev.processType.id,
//                     state: dev.state,
//                   ),
//                 )
//                 .toList(),
//           );
//         }
//         return const Center(
//           child: Text('Unexpected error arrived'),
//         );
//       },
//     );
//   }
// }

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
