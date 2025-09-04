import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class StopwatchProvider extends ChangeNotifier {
  final _stopwatch = Stopwatch();
  Duration elapsed = Duration.zero;
  Duration? lastElapsed; // store last stopped time
  late final Ticker _ticker;

  StopwatchProvider() {
    _ticker = Ticker(_onTick);
    _ticker.start();
  }

  void _onTick(Duration _) {
    if (_stopwatch.isRunning) {
      elapsed = _stopwatch.elapsed;
      notifyListeners();
    }
  }

  void start() {
    _stopwatch.start();
    notifyListeners();
  }

  void stop() {
    lastElapsed = elapsed; // save current time
    _stopwatch.stop();
    _stopwatch.reset(); // reset stopwatch immediately
    elapsed = Duration.zero;
    notifyListeners();
  }

  void reset() {
    _stopwatch.reset();
    elapsed = Duration.zero;
    lastElapsed = null;
    notifyListeners();
  }
}
