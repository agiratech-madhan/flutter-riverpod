import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app_riverpod/Home/models/genres_model.dart';
import 'package:movie_app_riverpod/Home/presentation/widgets/categories.dart';
import 'package:movie_app_riverpod/Home/presentation/widgets/movie_filters.dart';
import 'package:movie_app_riverpod/Home/presentation/widgets/movie_results.dart';
import 'package:movie_app_riverpod/Home/presentation/widgets/search_item.dart';
import 'package:movie_app_riverpod/constants.dart';

import '../controller/provider/providers.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(
    BuildContext context,
  ) {
    // ref.watch(genresListProvider);
    ref.listen(genresListProvider, (GenresList? q, GenresList c) {
      print(q?.genres.first.selected);
      print(c.genres.first.selected);
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black54,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: ListTile(
            title: RichText(
                text: const TextSpan(children: [
              TextSpan(
                  text: 'Hello ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextSpan(text: 'Flutter', style: TextStyle(fontSize: 20)),
            ])),
            subtitle: const Text(
              'The Movie Database',
              style: TextStyle(color: Colors.grey, fontSize: 17),
            ),
            trailing: CircleAvatar(
                backgroundImage: NetworkImage(Constants.userProfile)),
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          const MovieFilter(),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          const SearchMovie(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 33.0, vertical: 20),
            child: RichText(
              text: const TextSpan(children: [
                TextSpan(
                    text: 'Top Results',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ]),
            ),
          ),
          const Categories(),
          const MovieResult()
        ],
      ),
    );
  }
}
