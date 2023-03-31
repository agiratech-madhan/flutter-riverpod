import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

// final counterStateProvider = StateProvider<int>((ref) {
//   return 0;
// });
final clockProvider = StateNotifierProvider<Clock, DateTime>((ref) {
  return Clock();
});

class Clock extends StateNotifier<DateTime> {
  // 1. initialize with current time
  Clock() : super(DateTime.now()) {
    // 2. create a timer that fires every second
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      // 3. update the state with the current time
      state = DateTime.now();
    });
  }

  late final Timer _timer;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
