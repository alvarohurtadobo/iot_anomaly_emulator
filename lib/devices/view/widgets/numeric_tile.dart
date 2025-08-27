import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_anomaly_emulator/common/constants/sizes.dart';

class NumericTile extends ConsumerWidget {
  const NumericTile({required this.title, required this.value, super.key});

  final String title;
  final double? value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.p12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value?.toStringAsFixed(3) ?? 'n/a'),
        ],
      ),
    );
  }
}
