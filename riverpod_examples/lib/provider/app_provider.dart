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
// final labProvider = FutureProvider<LabCenter>((ref) {
//   final repo = ref.watch(repoRrovider);
//   return repo.getLabData();
// });
// final dataProvider = Provider.autoDispose<LabCenter>((value) {
//   final LabCenter data;
//   data = value;
// });
final labControllerProvider = StateNotifierProvider.autoDispose<
    LabCenterControllerNotifier, AsyncValue<LabCenter?>>((ref) {
  return LabCenterControllerNotifier(ref);
});
final isLoadingLabProvider = StateProvider<bool>((ref) {
  return true;
});

class LabCenterControllerNotifier
    extends StateNotifier<AsyncValue<LabCenter?>> {
  LabCenterControllerNotifier(this.ref) : super(const AsyncValue.loading()) {
    _service = ref!.watch(repoRrovider);

    fetLabList();
  } //AsyncValue.loading() //AsyncData(null)
  late LabRepository _service;
  final AutoDisposeStateNotifierProviderRef? ref;
  Future<void> fetLabList() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async => await _service.getLabData());
    ref?.read(isLoadingLabProvider.notifier).state = false;
  }
}
