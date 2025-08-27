import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_anomaly_emulator/common/constants/sizes.dart';
import 'package:iot_anomaly_emulator/devices/providers/currentProcessTypeProvider.dart';

class OptionTile extends ConsumerWidget {
  const OptionTile({
    required this.title,
    required this.optionsWithId,
    super.key,
  });

  final String title;
  final List<dynamic> optionsWithId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: Sizes.p12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          DropdownButton(
            items: optionsWithId
                .map(
                  (e) => DropdownMenuItem<int>(
                    value: e.id as int,
                    child: Text(e.displayName.toString()),
                  ),
                )
                .toList(),
            value: ref.watch(currentProcessTypeProvider),
            onChanged: (value) {
              ref.read(currentProcessTypeProvider.notifier).setValue(value);
            },
          ),
        ],
      ),
    );
  }
}
