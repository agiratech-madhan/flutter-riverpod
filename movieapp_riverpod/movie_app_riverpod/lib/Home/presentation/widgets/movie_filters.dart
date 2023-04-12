import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../controller/provider/providers.dart';
import '../filters.dart';

class MovieFilter extends ConsumerWidget {
  const MovieFilter({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieType = ref.watch(movieFilterProvider);
    final themeMode = ref.watch(themeProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: MovieType.values
          .map(
            (type) => GestureDetector(
              onTap: () => ref.read(movieFilterProvider.notifier).state = type,
              child: Container(
                height: 30,
                width: 90,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: type == movieType
                      ? themeMode
                          ? Colors.white
                          : Colors.grey
                      : null,
                ),
                child: Text(
                  type.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: themeMode
                          ? Colors.grey
                          : type != movieType
                              ? Colors.grey
                              : Colors.white),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
