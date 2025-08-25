import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_anomaly_emulator/common/constants/sizes.dart';
import 'package:iot_anomaly_emulator/devices/model/types.dart';

class DeviceButton extends ConsumerWidget {
  const DeviceButton({required this.name, required this.type, super.key});

  final String name;
  final DeviceTypes type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: Sizes.buttonSize,
      width: Sizes.buttonSize,
      margin: const EdgeInsets.all(Sizes.p8),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: const BorderRadius.all(
          Radius.circular(Sizes.buttonSize / 10),
        ),
        image: DecorationImage(
          image: AssetImage(
            type == DeviceTypes.imm
                ? 'assets/images/imm.jpg'
                : 'assets/images/arc.jpg',
          ),
        ),
      ),
      alignment: Alignment.bottomCenter,
      child: Text(name),
    );
  }
}
