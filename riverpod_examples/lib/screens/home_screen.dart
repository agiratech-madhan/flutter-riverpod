import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod/weather_provider.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterStateProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('title'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Value: $counter'),
            ElevatedButton(
              // 2. use the value
              child: Text('Increment'),
              // 3. change the state inside a button callback
              onPressed: () => ref.read(counterStateProvider.notifier).state++,
            ),
            ElevatedButton(
              // 2. use the value
              child: Text('decrement'),
              // 3. change the state inside a button callback
              onPressed: () => ref.read(counterStateProvider.notifier).state--,
            )
          ],
        ));
  }
}
