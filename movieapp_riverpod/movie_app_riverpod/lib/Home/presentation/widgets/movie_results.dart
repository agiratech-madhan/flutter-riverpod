import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../controller/provider/providers.dart';
import '../detail_page.dart';
import 'movie_stack.dart';

class MovieResult extends HookConsumerWidget {
  const MovieResult({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(movieControllerProvider);

    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.55,
        child: ListView.builder(
            itemCount: data.item.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) {
              final moviewValue = data.item[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                          imdbValue: moviewValue.voteAverage.toString(),
                          voteAverage: moviewValue.voteAverage!,
                          posterPath: moviewValue.posterPath ?? '',
                          popularity: moviewValue.popularity ?? 0,
                          title: moviewValue.title ?? '',
                          overView: moviewValue.overview ?? ''),
                    ),
                  );
                },
                child: MovieStack(
                    moviePath: moviewValue.posterPath.toString(),
                    voteAverage: moviewValue.voteAverage.toString()),
              );
            })));
  }
}
