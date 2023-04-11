import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
    final sets = ref.watch(selectedGenresListProvider);
    final isFiltered = ref.watch(filterSearchProvider);
    final data = ref.watch(movieControllerProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black54,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: ListTile(
            contentPadding: const EdgeInsets.all(0),
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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0),
            child: MovieFilter(),
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          const SearchMovie(),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                        text: 'Top Results',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ],
                ),
              ),
            ),
          ),
          const Flexible(child: Categories()),
          data == null
              ? const Align(
                  alignment: Alignment.center,
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Colors.grey,
                  )),
                )
              : (isFiltered && sets.isEmpty)
                  ? const Text("No result found")
                  : const MovieResult(),
        ],
      ),
    );
  }
}
