import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartDatetimeProvider extends Notifier<DateTime?> {
  @override
  DateTime? build() => null;

  void setValue(DateTime customDatetime) {
    state = customDatetime;
  }

  void setToNow() {
    state = DateTime.now();
  }
}

final currentStartDatetimeProvider =
    NotifierProvider<StartDatetimeProvider, DateTime?>(
      StartDatetimeProvider.new,
    );
