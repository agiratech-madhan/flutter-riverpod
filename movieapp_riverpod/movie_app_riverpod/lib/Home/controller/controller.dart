import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app_riverpod/Home/models/movie_model.dart';
import 'package:movie_app_riverpod/Home/repository/movie_repository.dart';

final repoProvider = Provider((ref) => MovieRepository());
final movieControllerProvider =
    StateNotifierProvider.autoDispose<MovieController, AsyncValue<Movies>>(
        (ref) => MovieController(ref));

class MovieController extends StateNotifier<AsyncValue<Movies>> {
  MovieController(this.ref) : super(const AsyncValue.loading()) {
    repo = ref!.read(repoProvider);
    fetchMovies();
  }
  late MovieRepository? repo;
  final AutoDisposeStateNotifierProviderRef? ref;
  Future<void> fetchMovies() async {
    final value = AsyncValue.data(await repo!.loadData(''));
    state = state.copyWithPrevious(value);
  }

  Future<void> filterMovie(String filterValue) async {
    final value = AsyncValue.data(await repo!.loadData(filterValue));
    state = state.copyWithPrevious(value);
  }
}
/**import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app_riverpod/Home/models/movie_model.dart';
import 'package:movie_app_riverpod/Home/repository/movie_repository.dart';

final repoProvider = Provider((ref) => MovieRepository());
final movieControllerProvider =
    StateNotifierProvider.autoDispose<MovieController, AsyncValue<Movies>>(
        (ref) => MovieController(ref));

class MovieController extends StateNotifier<AsyncValue<Movies>> {
  MovieController(this.ref) : super(const AsyncValue.loading()) {
    repo = ref!.read(repoProvider);
    fetchMovies();
  }
  late MovieRepository? repo;
  final AutoDisposeStateNotifierProviderRef? ref;

  Future<void> fetchMovies() async {
    final value = AsyncValue.data(await repo!.loadData(''));
    state = state.copyWithPrevious(value);
  }

  Future<void> filterMovie(String filterValue) async {
    final value = AsyncValue.data(await repo!.loadData(filterValue));
    state = state.copyWithPrevious(value);
  }
}
 */