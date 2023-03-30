import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod/weather_provider.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeather = ref.watch(wearherProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('title'),
        ),
        body: Column(
          children: [
            currentWeather.when(
                data: (data) {
                  return Text(data);
                },
                error: (error, stackTrace) => const Text('Error'),
                loading: () => const CircularProgressIndicator()),
            Expanded(
                child: ListView.builder(
                    itemCount: City.values.length,
                    itemBuilder: (context, index) {
                      final city = City.values[index];
                      final isSelected =
                          city == ref.watch(currentWeatherProvider);
                      return ListTile(
                        onTap: () => ref
                            .read(currentWeatherProvider.notifier)
                            .state = city,
                        title: Text(city.toString()),
                        trailing: isSelected ? Icon(Icons.check) : null,
                      );
                    }))
          ],
        ));
  }
}
