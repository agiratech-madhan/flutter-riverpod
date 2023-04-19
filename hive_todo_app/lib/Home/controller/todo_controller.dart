import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_todo_app/Home/presentaion/create.dart';
import 'package:hive_todo_app/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/todo_model.dart';
import '../provider/todo_provider.dart';
import '../repo/todorepo.dart';

// class TodoStateController extends StateNotifier<List<Todo>> {
//   TodoStateController()
//       : super(
//           [],
//         );
//   void addTodo(Todo todo) {
//     state = [...state, todo];
//   }

//   void updateTodo(String id, Todo todo) {
//     state = [
//       for (final s in state)
//         if (s.id == id)
//           Todo(
//               title: todo.title,
//               description: todo.description,
//               createdAt: todo.createdAt,
//               status: todo.status)
//         else
//           s,
//     ];
//   }

//   void removeTodo(int index, String id) {
//     state = state.where((todo) => todo.id != id).toList();
//   }
// }

class TodoHive extends StateNotifier<List<Todo>?> {
  TodoHive(this.ref) : super(null) {
    repo = ref.read(providerHive);
    fetchTodo();
  }
  late TodoRepo? repo;
  final StateNotifierProviderRef ref;
  void fetchTodo() {
    state = repo!.getValue();
  }

  void addTodo(Todo todo) {
    state = repo!.addValue(todo);
  }

  void removeTodo(String id) {
    state = repo!.removeTodo(id);
  }

  void updateTodo(int index, Todo todo) {
    state = repo!.updateTodo(index, todo);
  }
}
