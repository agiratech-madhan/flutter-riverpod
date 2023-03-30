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
    StateNotifierProvider.autoDispose<LabCenterControllerNotifier, LabCenter>(
        (ref) {
  return LabCenterControllerNotifier();
});
final isLoadingLabProvider = StateProvider<bool>((ref) {
  return true;
});

class LabCenterControllerNotifier extends StateNotifier<AsyncValue<LabCenter>> {
  LabCenterControllerNotifier() : super(const AsyncValue.loading()) {
    fetLabList(ref: ref!);
  }
  LabCenterControllerNotifier.create(LabCenter state)
      : super(AsyncValue.data(state));
  Ref? ref;
  Future<void> fetLabList({required Ref ref}) async {
    // await ref.read(repoRrovider).getLabData().then((value) {
    //   ref.read(isLoadingLabProvider.notifier).state = false;

    //   // state = value;
    // });
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final data = ref.watch(repoRrovider).getLabData();
      return data;
    });
  }
}
