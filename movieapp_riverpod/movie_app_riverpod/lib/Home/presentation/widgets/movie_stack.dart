// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import '../../../utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MovieStack extends HookConsumerWidget {
  const MovieStack({
    required this.moviePath,
    required this.voteAverage,
  });

  final String moviePath;
  final String voteAverage;
  // final String
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(Utils.posterPathUrl(moviePath))),
              borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.6,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(
                          Icons.star,
                          size: 30,
                          color: Colors.amber,
                        ),
                      ),
                      Text(
                        voteAverage,
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Chip(
                          backgroundColor: Colors.amber,
                          labelStyle: const TextStyle(
                              fontSize: 17, color: Colors.black),
                          label: Text('IMDB $voteAverage'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
