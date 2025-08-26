import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iot_anomaly_emulator/common/constants/sizes.dart';
import 'package:iot_anomaly_emulator/devices/model/types.dart';
import 'package:iot_anomaly_emulator/l10n/l10n.dart';

class DeviceButton extends ConsumerWidget {
  const DeviceButton({
    required this.id,
    required this.name,
    required this.type,
    super.key,
  });

  final int id;
  final String name;
  final DeviceTypes type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return GestureDetector(
      onTap: () {
        context.go('/device/$id');
      },
      child: Container(
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
              type == DeviceTypes.other
                  ? 'assets/images/other.jpg'
                  : type == DeviceTypes.imm
                  ? 'assets/images/imm.jpg'
                  : 'assets/images/arc.jpg',
            ),
          ),
        ),
        alignment: Alignment.bottomCenter,
        child: Text(name),
      ),
    );
  }
}
