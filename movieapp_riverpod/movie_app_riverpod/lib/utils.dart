import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class Utils {
  static String posterPathUrl(String url) {
    return 'https://image.tmdb.org/t/p/w185/$url';
  }
}

extension DebounceExtension on Ref {
  /// delays the execution of the code for the given duration,
  /// if any dependency changes during the period,
  /// the timer will reset and restart
  /// if nothing changes, the rest of the code will be executed.
  Future<void> debounce([
    Duration duration = const Duration(milliseconds: 350),
  ]) {
    final completer = Completer<void>();

    /// creates a timer with the given duration
    /// when the time expires, and the completer hasn't completed yet, complete it.
    /// and the debounce function lets the rest of the code executed
    final timer = Timer(duration, () {
      if (!completer.isCompleted) completer.complete();
    });

    /// if provider disposed and the completer hasn't completed yet
    /// cancel the timer and throw canceled error
    onDispose(() {
      timer.cancel();
      if (!completer.isCompleted) {
        completer.completeError(StateError('Canceled'));
      }
    });

    return completer.future;
  }
}
