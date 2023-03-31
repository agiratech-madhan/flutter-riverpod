// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../models/photo_model.dart';
// import '../repository/photo_repository.dart';

// final idValue = StateProvider<String?>((ref) => '');
// final photoProvider = FutureProvider<Photos>((ref) {
//   final id = ref.watch(idValue);
//   final repo = ref.watch(repoRrovider);
//   return repo.getPhotos(id: id);
// });

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/lab_model.dart';
import '../repository/lab_repository.dart';

final repoRrovider = Provider((ref) => LabRepository());
final labProvider = FutureProvider<LabCenter>((ref) {
  final repo = ref.watch(repoRrovider);
  return repo.getLabData();
});
final labControllerProvider =
    StateNotifierProvider<LabCenterControllerNotifier, AsyncValue<LabCenter?>>(
        (ref) {
  return LabCenterControllerNotifier();
});
final isLoadingLabProvider = StateProvider<bool>((ref) {
  return true;
});

class LabCenterControllerNotifier
    extends StateNotifier<AsyncValue<LabCenter?>> {
  LabCenterControllerNotifier() : super(const AsyncData(null)) {
    fetLabList(ref: ref!);
  } //AsyncValue.loading()
  LabCenterControllerNotifier.create(LabCenter state)
      : super(AsyncValue.data(state));
  Ref? ref;
  Future<void> fetLabList({required Ref ref}) async {
    // final data = ref.read(repoRrovider).getLabData();
    // // .then((value) {
    // // });
    final repo = ref.read(repoRrovider);
    // state = data!;
    // return state;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() {
      return repo.getLabData();
    }

        // repo.getLabData()
        //  async {
        //   state = ref.read(repoRrovider).getLabData();
        //   // return data;
        // }

        );
    ref.read(isLoadingLabProvider.notifier).state = false;
  }
}
