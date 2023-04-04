// import 'package:hooks_riverpod/hooks_riverpod.dart'

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app_riverpod/Home/controller/controller.dart';
import 'package:movie_app_riverpod/Home/presentation/widgets/movie_stack.dart';
import 'package:movie_app_riverpod/constants.dart';

import '../models/movie_model.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(movieControllerProvider);
    // print(data.value?.item.length);
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
          Autocomplete<MovieData>(
            optionsBuilder: (textEditingValue) {
              if (textEditingValue.text == '') {
                return List.empty();
              } else {
                return data.item
                    .where((element) => element.title!
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase()))
                    .toList();
              }
            },
            fieldViewBuilder: (BuildContext context,
                TextEditingController controller,
                FocusNode focusNode,
                Function onFieldSubmitted) {
              return TextField(
                onSubmitted: (value) async {
                  FocusManager.instance.primaryFocus?.unfocus();

                  ref.read(movieControllerProvider.notifier).filterMovie(value);

                  // isSearch = true;
                  // await provider.loadData(controller.text);

                  // isSearch = false;
                  // FocusManager.instance.primaryFocus?.unfocus();
                },
                focusNode: focusNode,
                controller: controller,
                decoration: InputDecoration(
                    hintText: 'Search',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.7),
                    prefixIconColor: Colors.red,
                    prefixIcon: IconButton(
                        onPressed: (() async {
                          // isSearch = true;
                          // await provider.loadData(controller.text);

                          // isSearch = false;
                          // FocusManager.instance.primaryFocus?.unfocus();
                        }),
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        )),
                    suffixIcon: const Icon(
                      Icons.mic_none_rounded,
                      color: Colors.grey,
                    ),
                    suffixIconColor: Colors.grey),
              );
            },
            onSelected: (option) async {
              try {
                ref
                    .read(movieControllerProvider.notifier)
                    .filterMovie(option.title!.toLowerCase());
                FocusManager.instance.primaryFocus?.unfocus();

                // isSearch = true;
                // await provider.loadData((option.title)!.toLowerCase());
                // FocusManager.instance.primaryFocus?.unfocus();
                // isSearch = false;
              } catch (e) {
                throw 'Error Ocuured';
              }
            },
            displayStringForOption: (option) {
              return option.title!;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 33.0, vertical: 40),
            child: RichText(
              text: const TextSpan(children: [
                TextSpan(
                    text: 'Featured Movies',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ]),
            ),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: ListView.builder(
                  itemCount: data.item.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) {
                    final moviewValue = data.item[index];
                    return MovieStack(
                        moviePath: moviewValue.posterPath.toString(),
                        voteAverage: moviewValue.voteAverage.toString());
                  }))),
        ],
      )
      // Autocomplete<MovieData>(
      //   // optionsBuilder: (textEditingValue) {
      //   //   return ''as List;
      //   //   // if (textEditingValue.text == '') {
      //   //   //   return List.empty();
      //   //   // } else {
      //   //   //   return provider.moviesSearch!.item
      //   //   //       .where((e) =>
      //   //   //           // print('Madhan${e.title}');
      //   //   //           e.title!.toLowerCase().contains(
      //   //   //               textEditingValue.text.toLowerCase()))
      //   //   //       .toList();
      //   //   // }
      //   // },
      //   fieldViewBuilder: (BuildContext context,
      //       TextEditingController controller,
      //       FocusNode focusNode,
      //       Function onFieldSubmitted) {
      //     // this.controller = controller;
      //     return TextField(
      //       onSubmitted: (value) async {
      //         // isSearch = true;
      //         // await provider.loadData(controller.text);

      //         // isSearch = false;
      //         // FocusManager.instance.primaryFocus?.unfocus();
      //       },
      //       focusNode: focusNode,
      //       controller: controller,
      //       decoration: InputDecoration(
      //           hintText: 'Search',
      //           border: OutlineInputBorder(
      //             borderSide: BorderSide.none,
      //             borderRadius: BorderRadius.circular(20.0),
      //           ),
      //           filled: true,
      //           fillColor: Colors.grey.withOpacity(0.7),
      //           prefixIconColor: Colors.red,
      //           prefixIcon: IconButton(
      //               onPressed: (() async {
      //                 // isSearch = true;
      //                 // await provider.loadData(controller.text);

      //                 // isSearch = false;
      //                 // FocusManager.instance.primaryFocus?.unfocus();
      //               }),
      //               icon: const Icon(
      //                 Icons.search,
      //                 color: Colors.white,
      //               )),
      //           suffixIcon: const Icon(
      //             Icons.mic_none_rounded,
      //             color: Colors.grey,
      //           ),
      //           suffixIconColor: Colors.grey),
      //     );
      //   },
      //   onSelected: (option) async {
      //     // try {
      //     //   isSearch = true;
      //     //   await provider.loadData((option.title)!.toLowerCase());
      //     //   FocusManager.instance.primaryFocus?.unfocus();
      //     //   isSearch = false;
      //     // } catch (e) {
      //     //   throw 'Error Ocuured';
      //     // }
      //   },
      //   displayStringForOption: (MovieData d) {
      //     return d.title!;
      //   },
      // ),

      ,
    );
  }
}
