import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app_riverpod/Home/presentation/detail_page.dart';

import '../../utils.dart';
import '../controller/provider/providers.dart';

class FavScreen extends HookConsumerWidget {
  const FavScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(fav);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Movies List"),
      ),
      body: d.when(
        data: (data) {
          return ListView.builder(
              itemCount: data.item.length,
              itemBuilder: (context, index) {
                final movieItem = data.item.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                              imdbValue: movieItem.voteAverage.toString(),
                              voteAverage: movieItem.voteAverage!,
                              posterPath: movieItem.posterPath ?? '',
                              popularity: movieItem.popularity ?? 0,
                              title: movieItem.title ?? '',
                              overView: movieItem.overview ?? ''),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Image.network(
                        Utils.posterPathUrl(
                          movieItem.posterPath.toString(),
                        ),
                      ),
                      title: Text(
                        movieItem.title.toString(),
                      ),
                      subtitle: Text(
                        movieItem.overview.toString(),
                        maxLines: 2,
                      ),
                    ),
                  ),
                );
              });
        },
        error: (s, t) {
          return const Text("data");
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
