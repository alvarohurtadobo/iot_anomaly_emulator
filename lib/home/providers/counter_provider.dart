import 'package:flutter_riverpod/flutter_riverpod.dart';

class Counter extends Notifier<int> {
  @override
  int build() => 0;

  void increment() {
    state++;
  }

  void decrement() {
    if (state > 0) {
      state--;
    }
  }
}

final counterProvider = NotifierProvider<Counter, int>(Counter.new);
