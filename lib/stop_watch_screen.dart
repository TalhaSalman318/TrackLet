import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_let/stop_watch_provider.dart';
import 'package:track_let/neon_circle_painter.dart';

class StopWatchScreen extends StatelessWidget {
  const StopWatchScreen({super.key});

  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final millis = (duration.inMilliseconds.remainder(1000) ~/ 10)
        .toString()
        .padLeft(2, '0');
    return "$minutes:$seconds.$millis";
  }

  @override
  Widget build(BuildContext context) {
    final stopwatchProvider = context.watch<StopwatchProvider>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "TrackLet",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.cyanAccent,
            shadows: [
              Shadow(
                blurRadius: 20,
                color: Colors.deepOrangeAccent,
                offset: Offset(0, 0),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Neon Animated Circle
          TweenAnimationBuilder<double>(
            tween: Tween<double>(
              begin: 0,
              end: stopwatchProvider.elapsed.inMilliseconds / 60000,
            ),
            duration: const Duration(milliseconds: 300),
            builder: (context, value, child) {
              return CustomPaint(
                painter: NeonCirclePainter(progress: value),
                child: Container(
                  width: 260,
                  height: 260,
                  alignment: Alignment.center,
                  child: Text(
                    _formatTime(stopwatchProvider.elapsed),
                    style: const TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyanAccent,
                      fontFamily: "monospace",
                      shadows: [
                        Shadow(
                          blurRadius: 15,
                          color: Colors.cyanAccent,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 20),

          // Last Stopped Time
          if (stopwatchProvider.lastElapsed != null)
            Text(
              "Last Stopped: ${_formatTime(stopwatchProvider.lastElapsed!)}",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.orangeAccent,
                fontWeight: FontWeight.w600,
              ),
            ),

          const SizedBox(height: 50),

          // Control Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _button("Start", Colors.greenAccent, stopwatchProvider.start),
              const SizedBox(width: 15),
              _button("Stop", Colors.redAccent, stopwatchProvider.stop),
              const SizedBox(width: 15),
              _button("Reset", Colors.purpleAccent, stopwatchProvider.reset),
            ],
          ),
        ],
      ),
    );
  }

  Widget _button(String label, Color color, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: color,
        side: BorderSide(color: color, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shadowColor: color,
        elevation: 10,
      ),
      child: Text(label),
    );
  }
}
