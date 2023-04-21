import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/todo_model.dart';
import '../provider/todo_provider.dart';
import '../repo/todorepo.dart';

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
