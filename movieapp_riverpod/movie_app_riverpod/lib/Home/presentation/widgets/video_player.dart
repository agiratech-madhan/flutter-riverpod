// // import 'package:flutter/material.dart';
// // import 'package:video_player/video_player.dart';

// // class VideoPlayerRemote extends StatefulWidget {
// //   final String? url;
// //   VideoPlayerRemote({this.url});
// //   @override
// //   _VideoPlayerRemoteState createState() => _VideoPlayerRemoteState();
// // }

// // class _VideoPlayerRemoteState extends State<VideoPlayerRemote> {
// //   late VideoPlayerController _controller;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _controller = VideoPlayerController.network(
// //       widget.url!, //to access its parent class constructor or variable
// //     );

// //     _controller.addListener(() {
// //       setState(() {});
// //     });
// //     _controller.setLooping(true); //loop through video
// //     _controller.initialize(); //initialize the VideoPlayer
// //   }

// //   @override
// //   void dispose() {
// //     _controller.dispose(); //dispose the VideoPlayer
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return SingleChildScrollView(
// //       child: Column(
// //         children: <Widget>[
// //           Container(padding: const EdgeInsets.only(top: 20.0)),
// //           Container(
// //             padding: const EdgeInsets.all(20),
// //             child: AspectRatio(
// //               aspectRatio: _controller.value.aspectRatio,
// //               child: Stack(
// //                 alignment: Alignment.bottomCenter,
// //                 children: <Widget>[
// //                   VideoPlayer(_controller),
// //                   _PlayPauseOverlay(controller: _controller),
// //                   VideoProgressIndicator(_controller, allowScrubbing: true),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class _PlayPauseOverlay extends StatelessWidget {
// //   const _PlayPauseOverlay({Key? key, required this.controller})
// //       : super(key: key);

// //   final VideoPlayerController controller;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Stack(
// //       children: <Widget>[
// //         AnimatedSwitcher(
// //           duration: Duration(milliseconds: 50),
// //           reverseDuration: Duration(milliseconds: 200),
// //           child: controller.value.isPlaying
// //               ? SizedBox.shrink()
// //               : Container(
// //                   color: Colors.black26,
// //                   child: Center(
// //                     child: Icon(
// //                       Icons.play_arrow,
// //                       color: Colors.white,
// //                       size: 100.0,
// //                     ),
// //                   ),
// //                 ),
// //         ),
// //         GestureDetector(
// //           onTap: () {
// //             controller.play();
// //           },
// //         ),
// //       ],
// //     );
// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// import 'package:movie_app_riverpod/Home/controller/provider/providers.dart';
// import 'package:movie_app_riverpod/Home/presentation/widgets/video_player.dart';
// import 'package:video_player/video_player.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class DetailPage extends StatefulHookConsumerWidget {
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

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _DetailPageState();
// }

// class _DetailPageState extends ConsumerState<DetailPage> {
//   late YoutubePlayerController youtubePlayerController;
//   @override
//   void initState() {
//     String? url;

//     // TODO: implement initState
//     // Widget.addPostFrameCal
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       // ref.watch(cartControllerProvider);
//       final videos = ref.watch(videoProvider(widget.id.toString()));
//       url = videos.value?.videos.first.key;
//     });
//     youtubePlayerController = YoutubePlayerController(initialVideoId: '$url');
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     const controller = VideoPlayerController;
//     final c = useState('');
//     final videos = ref.watch(videoProvider(widget.id.toString()));

//     final theme = ref.watch(themeProvider);
//     // print(videos.value?.videos.length);
//     return Scaffold(
//       backgroundColor: !theme ? Colors.white : Colors.black,
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             icon: Icon(
//               Icons.arrow_back,
//               color: theme ? Colors.white : Colors.black,
//             )),
//         title: Text(widget.title),
//         /**
//          * Container(
//               height: 50,
//               width: 50,
//               child: videos.when(
//                   data: (data) {
//                     return Text(data.videos.length.toString());
//                   },
//                   error: (e, r) => Text('error'),
//                   loading: () => CircularProgressIndicator()),
//             ),
//          */
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               margin: const EdgeInsets.all(20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Container(
//                     height: MediaQuery.of(context).size.height * 0.4,
//                     width: double.infinity,
//                     // decoration: BoxDecoration(
//                     //   image: DecorationImage(
//                     //       fit: BoxFit.cover,
//                     //       image: NetworkImage(
//                     //           'https://image.tmdb.org/t/p/w185/$posterPath')),
//                     // ),
//                     child: videos.when(
//                         data: (data) {
//                           return YoutubePlayer(
//                               controller: youtubePlayerController);
//                         },
//                         error: (e, r) => Text('error'),
//                         loading: () => CircularProgressIndicator()),
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(right: 8.0),
//                             child: Chip(
//                               backgroundColor: Colors.amber,
//                               labelStyle: const TextStyle(
//                                   fontSize: 17, color: Colors.black),
//                               label: Text('IMDB ${widget.voteAverage}'),
//                             ),
//                           ),
//                           const Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 8.0),
//                             child: Icon(
//                               Icons.star,
//                               size: 30,
//                               color: Colors.amber,
//                             ),
//                           ),
//                           Text(
//                             '${widget.voteAverage}',
//                             style: const TextStyle(
//                                 color: Colors.amber,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             ' (${(widget.popularity).round()}K reviews)',
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                             ),
//                           )
//                           // const Spacer(),
//                         ],
//                       ),
//                       Text(
//                         widget.title,
//                         textAlign: TextAlign.left,
//                         style: TextStyle(
//                             fontSize: 20,
//                             color: !theme ? Colors.black : Colors.white,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 10, right: 25),
//                         child: SizedBox(
//                           // height: 135,
//                           child: Text(
//                             widget.overView,
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 color: !theme ? Colors.black : Colors.white),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
// // class DetailPage extends ConsumerWidget {
// //   const DetailPage({
// //     Key? key,
// //     required this.imdbValue,
// //     required this.voteAverage,
// //     required this.posterPath,
// //     required this.popularity,
// //     required this.title,
// //     required this.overView,
// //     required this.id,
// //   }) : super(key: key);
// //   final String imdbValue;
// //   final num voteAverage;
// //   final String posterPath;
// //   final double popularity;
// //   final String title;
// //   final String overView;
// //   final int id;

 

// // }

// //   }
// // }
