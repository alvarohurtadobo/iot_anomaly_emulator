import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentProcessType extends Notifier<int?> {
  @override
  int? build() => null;

  void setValue(int? value) {
    state = value;
  }

  void clear() {
    state = null;
  }
}

final currentProcessTypeProvider = NotifierProvider<CurrentProcessType, int?>(
  CurrentProcessType.new,
);
