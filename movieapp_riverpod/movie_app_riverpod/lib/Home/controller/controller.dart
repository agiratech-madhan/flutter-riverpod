import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app_riverpod/Home/models/movie_model.dart';
import 'package:movie_app_riverpod/Home/repository/movie_repository.dart';

final repoProvider = Provider((ref) => MovieRepository());
final movieControllerProvider =
    StateNotifierProvider.autoDispose<MovieController, Movies>((ref) {
  // ref.onDispose(() {
  //   FocusManager.instance.primaryFocus?.unfocus();
  // });
  return MovieController(ref);
});

class MovieController extends StateNotifier<Movies> {
  MovieController(this.ref) : super(Movies(item: [])) {
    repo = ref!.read(repoProvider);
    fetchMovies();
  }
  late MovieRepository? repo;
  final StateNotifierProviderRef? ref;
  Future<void> fetchMovies() async {
    final value = await repo?.loadData('');
    state = value!;
    // state = state.copyWithPrevious(value);
  }

  Future<void> filterMovie(String filterValue) async {
    final value = await repo?.loadData(filterValue);
    state = state.copyWith(item: value!.item);
  }
}
