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
    final sets = ref.watch(filterProvider);
    final isFiltered = ref.watch(filterSearchProvider);
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
        mainAxisSize: MainAxisSize.min,
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
          // Container(
          //   height: 200,
          //   child: ListView.builder(
          //     // controller: ,
          //     itemCount: data.genres.length,
          //     itemBuilder: (context, index) {
          //       // final se = ref.watch(selectedProvider(index));
          //       final element = data.genres.elementAt(index);
          //       final s = ref.read(selectedProvider(index).notifier);
          //       final sem = sets[index];
          //       return ListTile(
          //         leading: Checkbox(
          //           value: sem,
          //           onChanged: (value) {
          //             // print(
          //             //     ref.watch(genresListProvider).genres[index].selected);
          //             ref
          //                 .read(genresListProvider.notifier)
          //                 .updateOption(element.id, value!);
          //             // ref.read(genresListProvider.notifier).refreshState();
          //             // s.update((state)=>state(data.genres))
          //             // print(
          //             //     ref.watch(genresListProvider).genres[index].selected);

          //             // print(value);
          //           },
          //         ),
          //         title: Text(element.name),
          //       );
          //     },
          //   ),
          // ),

          // SizedBox(height: 70, child: const Categories()),

          // Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     SizedBox(width: 70, height: 60, child: Text("data")),

          //     // Flexible(
          //     // child:
          //     Expanded(
          //       flex: 0,
          //       child: SizedBox(
          //         height: 140,
          //         // child:
          //         // Flexible(
          //         //   child: ListView(
          //         //     scrollDirection: Axis.horizontal,
          //         //   ),
          //         // ),
          //       ),
          //     )
          //   ],
          // )
          const Flexible(child: Categories()),
          (isFiltered && sets.isEmpty)
              ? const Text("No result found")
              : const MovieResult()
        ],
      ),
    );
  }
}
