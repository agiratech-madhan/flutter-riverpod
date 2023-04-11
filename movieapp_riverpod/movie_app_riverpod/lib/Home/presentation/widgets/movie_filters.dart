import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../controller/provider/providers.dart';
import '../filters.dart';

class MovieFilter extends ConsumerWidget {
  const MovieFilter({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieType = ref.watch(movieFilterProvider);
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
                  color: type == movieType ? Colors.grey : null,
                ),
                child: Text(
                  type.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),

              // Chip(
              // label: Text(
              //   type.name,
              // ),
              //   backgroundColor: type == movieType ? Colors.blue : null,
              // ),
            ),
          )
          .toList(),
    );
  }
}
