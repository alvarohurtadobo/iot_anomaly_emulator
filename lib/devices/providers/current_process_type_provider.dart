import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentProcessType extends Notifier<int?> {
  @override
  int? build() => null;

  set value(int? newValue) => state = newValue;

  int? get value => state;

  void clear() {
    state = null;
  }
}

final currentProcessTypeProvider = NotifierProvider<CurrentProcessType, int?>(
  CurrentProcessType.new,
);
