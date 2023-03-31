import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod/counter_provider.dart';
import 'package:intl/intl.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    // format the time as `hh:mm:ss`
    return Scaffold(
        appBar: AppBar(
          title: const Text('title'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  // 2. use the value
                  child: Text('Value: $counter'),
                  // 3. change the state inside a button callback
                  onPressed: () =>
                      ref.read(counterProvider.notifier).increment(),
                ))
          ],
        ));
  }
}
