import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../controller/todo_controller.dart';
import '../model/todo_model.dart';
import '../../utils.dart';
import '../repo/todorepo.dart';

final statusProvider = StateProvider<Status>((ref) => Status.all);
final filterProvider = StateProvider<Status>((ref) => Status.all);
// final todoDaTaProvider = StateNotifierProvider<TodoStateController, List<Todo>>(
//     (ref) => TodoStateController());
final filteredDataProvider = Provider<List<Todo>>((ref) {
  // final data = ref.watch(todoDaTaProvider);
  final data = ref.watch(hiveData);
  // final value = ref.watch(hiveData);

  final status = ref.watch(filterProvider);
  switch (status) {
    case Status.completed:
      return data!.where((todo) {
        // print(todo.status);
        return todo.status == 'completed';
      }).toList();
    case Status.pending:
      return data!.where((todo) => todo.status == 'pending').toList();
    case (Status.all):
      return data!.toList();
  }
});
final providerHive = Provider<TodoRepo>((ref) => TodoRepo());
final hiveData =
    StateNotifierProvider<TodoHive, List<Todo>?>((ref) => TodoHive(ref));
