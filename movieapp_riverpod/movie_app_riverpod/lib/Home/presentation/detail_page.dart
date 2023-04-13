// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:movie_app_riverpod/Home/controller/provider/providers.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailPage extends StatefulHookConsumerWidget {
  const DetailPage({
    Key? key,
    required this.imdbValue,
    required this.voteAverage,
    required this.posterPath,
    required this.popularity,
    required this.title,
    required this.overView,
    required this.id,
  }) : super(key: key);
  final String imdbValue;
  final num voteAverage;
  final String posterPath;
  final double popularity;
  final String title;
  final String overView;
  final String id;
  // final STr

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  late YoutubePlayerController youtubePlayerController;
  @override
  void initState() {
    youtubePlayerController =
        YoutubePlayerController(initialVideoId: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);

    return Scaffold(
      backgroundColor: !theme ? Colors.white : Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: theme ? Colors.white : Colors.black,
            )),
        title: Text(widget.title),
        /**
         * Container(
              height: 50,
              width: 50,
              child: videos.when(
                  data: (data) {
                    return Text(data.videos.length.toString());
                  },
                  error: (e, r) => Text('error'),
                  loading: () => CircularProgressIndicator()),
            ),
         */
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: double.infinity,
                    // decoration: BoxDecoration(
                    //   image: DecorationImage(
                    //       fit: BoxFit.cover,
                    //       image: NetworkImage(
                    //           'https://image.tmdb.org/t/p/w185/$posterPath')),
                    // ),
                    child: YoutubePlayer(controller: youtubePlayerController),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Chip(
                              backgroundColor: Colors.amber,
                              labelStyle: const TextStyle(
                                  fontSize: 17, color: Colors.black),
                              label: Text('IMDB ${widget.voteAverage}'),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(
                              Icons.star,
                              size: 30,
                              color: Colors.amber,
                            ),
                          ),
                          Text(
                            '${widget.voteAverage}',
                            style: const TextStyle(
                                color: Colors.amber,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ' (${(widget.popularity).round()}K reviews)',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          )
                          // const Spacer(),
                        ],
                      ),
                      Text(
                        widget.title,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20,
                            color: !theme ? Colors.black : Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 25),
                        child: SizedBox(
                          // height: 135,
                          child: Text(
                            widget.overView,
                            style: TextStyle(
                                fontSize: 18,
                                color: !theme ? Colors.black : Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
// class DetailPage extends ConsumerWidget {
//   const DetailPage({
//     Key? key,
//     required this.imdbValue,
//     required this.voteAverage,
//     required this.posterPath,
//     required this.popularity,
//     required this.title,
//     required this.overView,
//     required this.id,
//   }) : super(key: key);
//   final String imdbValue;
//   final num voteAverage;
//   final String posterPath;
//   final double popularity;
//   final String title;
//   final String overView;
//   final int id;

 

// }
