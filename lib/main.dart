import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_let/stop_watch_provider.dart';
import 'package:track_let/stop_watch_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => StopwatchProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StopWatchScreen(),
    );
  }
}
