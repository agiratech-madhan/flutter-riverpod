import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/photo_model.dart';
import '../repository/photo_repository.dart';

final idValue = StateProvider<String?>((ref) => '');
final photoProvider = FutureProvider<Photos>((ref) {
  final id = ref.watch(idValue);
  final repo = ref.watch(repoRrovider);
  return repo.getPhotos(id: id);
});

final repoRrovider = Provider((ref) => PhotoRepository());
