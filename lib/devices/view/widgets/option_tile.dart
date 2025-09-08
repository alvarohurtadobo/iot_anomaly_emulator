import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_anomaly_emulator/common/constants/sizes.dart';

class OptionTile extends ConsumerWidget {
  const OptionTile({
    required this.title,
    required this.optionsWithId,
    required this.onChanged,
    required this.value,
    super.key,
  });

  final String title;
  final List<dynamic> optionsWithId;
  final int value;
  final void Function(int?) onChanged;

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
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
