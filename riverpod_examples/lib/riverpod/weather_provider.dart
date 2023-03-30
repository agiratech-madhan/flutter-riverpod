import 'package:flutter_riverpod/flutter_riverpod.dart';

enum City { one, two, three, four }

typedef WeatherEmoji = String;
Future<WeatherEmoji> getNumber(City city) {
  return Future.delayed(
      const Duration(seconds: 1),
      () => {
            City.one: 'one',
            City.two: 'two',
            City.three: 'three',
            City.four: 'four',
          }[city]!);
}

final currentWeatherProvider = StateProvider<City?>((ref) => null);
final wearherProvider = FutureProvider<WeatherEmoji>((ref) {
  final x = ref.watch(currentWeatherProvider);
  if (x != null) {
    return getNumber(x);
  } else {
    return 'show All Values';
  }
});
