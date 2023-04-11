import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app_riverpod/Home/controller/provider/providers.dart';
import 'package:movie_app_riverpod/Home/models/movie_model.dart';
import 'package:movie_app_riverpod/Home/presentation/filters.dart';
import 'package:movie_app_riverpod/Home/repository/movie_repository.dart';

class MovieController extends StateNotifier<Movies?> {
  MovieController(this.ref) : super(null) {
    repo = ref!.read(repoProvider);
    fetchMovies();
  }
  late MovieRepository? repo;
  final StateNotifierProviderRef? ref;
  Future<void> fetchMovies({String filterValue = ''}) async {
    // ref?.read(isLoadingProvider.notifier).state = true;

    final filter = ref!.watch(movieFilterProvider);
    final value = await repo?.loadData(filterValue, filterType: filter.value);

    final sets = ref!.watch(selectedGenresListProvider);
    final isSearched = ref!.watch(filterSearchProvider);
    // ref?.read(isLoadingProvider.notifier).state = false;

    if (isSearched == true) {
      final filteredData = sets.isEmpty
          ? value?.item.toList()
          : value?.item
              .where(
                (element) => Set.of(element.genrId!)
                    .containsAll(sets.map((e) => e.id).toList()),
              )
              .toList();

      state = sets.isEmpty
          ? value!
          : Movies(
              item: filteredData!,
            );
    } else {
      // ref?.read(isLoadingProvider.notifier).state = true;

      state = value!;
      // ref?.read(isLoadingProvider.notifier).state = false;
    }
  }

  Future<void> updateFilter() async {
    final filter = ref!.watch(movieFilterProvider);
    final value = await repo?.loadData('', filterType: filter.value);

    final sets = ref!.watch(selectedGenresListProvider);
    print(sets);
    final filteredData = sets.isEmpty
        ? value?.item.toList()
        : value?.item
            .where(
              (element) => Set.of(element.genrId!)
                  .containsAll(sets.map((e) => e.id).toList()),
            )
            .toList();
    print("filteredData$filteredData");
    state = sets.isEmpty
        ? value!
        : Movies(
            item: filteredData!,
          );
  }
}
