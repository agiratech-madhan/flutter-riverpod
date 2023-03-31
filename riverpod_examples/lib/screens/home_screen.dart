import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod/time_provider.dart';
import 'package:intl/intl.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTime = ref.watch(clockProvider);
    // format the time as `hh:mm:ss`
    final timeFormatted = DateFormat.Hms().format(currentTime);
    return Scaffold(
        appBar: AppBar(
          title: const Text('title'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(alignment: Alignment.center, child: Text(timeFormatted))
          ],
        ));
  }
}
