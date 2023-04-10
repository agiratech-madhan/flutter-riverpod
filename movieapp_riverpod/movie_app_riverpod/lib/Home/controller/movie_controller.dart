import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app_riverpod/Home/controller/provider/providers.dart';
import 'package:movie_app_riverpod/Home/models/movie_model.dart';
import 'package:movie_app_riverpod/Home/presentation/filters.dart';
import 'package:movie_app_riverpod/Home/repository/movie_repository.dart';

class MovieController extends StateNotifier<Movies> {
  MovieController(this.ref) : super(Movies(item: [])) {
    repo = ref!.read(repoProvider);
    fetchMovies();
  }
  late MovieRepository? repo;
  final StateNotifierProviderRef? ref;
  Future<void> fetchMovies({String filterValue = ''}) async {
    final filter = ref!.watch(movieFilterProvider);
    // ref?.read(isLoadingProvider.notifier).state = true;
    final value = await repo?.loadData(filterValue, filterType: filter.value);
    // print(filter.value);
    final sets = ref!.watch(filterProvider);
    final isSearched = ref!.watch(filterSearchProvider);

    // print('isSearched$isSearched');
    if (isSearched == true) {
      // print('value$value');

      // print(sets.map((e) => e.id).toList());
      final filteredData = sets.isEmpty
          ? value?.item.toList()
          : value?.item
              .where(
                (element) => Set.of(element.genrId!)
                    .containsAll(sets.map((e) => e.id).toList()),
              )
              .toList();
      // print(value.item.)
      // ref?.read(isLoadingProvider.notifier).state = false;

      print('filterdata$filteredData');
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
}
