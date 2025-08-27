import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartDatetimeProvider extends Notifier<DateTime?> {
  @override
  DateTime? build() => null;

  set value(DateTime? newDatetime) => state = newDatetime;

  DateTime? get value => state;

  void setToNow() {
    state = DateTime.now();
  }
}

final currentStartDatetimeProvider =
    NotifierProvider<StartDatetimeProvider, DateTime?>(
      StartDatetimeProvider.new,
    );
