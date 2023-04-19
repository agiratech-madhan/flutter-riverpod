import 'package:flutter/foundation.dart';
import 'package:hive_todo_app/Home/pages/create.dart';
import 'package:hive_todo_app/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/todo_model.dart';

// final dataProvider = ChangeNotifierProvider<TodoState>((ref) => TodoState());

class TodoStateController extends StateNotifier<List<Todo>> {
  TodoStateController()
      : super(
          [],
        );
  void addTodo(Todo todo) {
    // state.add(todo);
    state = [...state, todo];
  }

  void updateTodo(String id, Todo todo) {
    state = [
      for (final s in state)
        if (s.id == id)
          Todo(
              title: todo.title,
              description: todo.description,
              createdAt: todo.createdAt,
              status: todo.status)
        else
          s,
    ];
  }

  void removeTodo(int index, String id) {
    state = state.where((todo) => todo.id != id).toList();
  }
}
