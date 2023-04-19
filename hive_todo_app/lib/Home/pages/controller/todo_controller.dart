import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/todo_model.dart';

final todoProvider = Provider<List<Todo>>((ref) {
  final data = ref.watch(dataProvider);

  return data.todos;
});

final dataProvider = ChangeNotifierProvider<TodoState>((ref) => TodoState());

class TodoState extends ChangeNotifier {
  List<Todo> _todos = [];
  List<Todo> get todos => _todos;
  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void removeTodo(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }

  void updateTodo(String id, Todo todo) {
    final index = _todos.indexWhere((element) => element.id == id);
    _todos[index] = todo;
    notifyListeners();
  }
}
