// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_todo_app/Home/model/todo_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// final repoProvider = FutureProvider<TodoRepo>((ref) async {
//    await Hive.openBox<Todo>('todos');
//   return TodoRepo();
// });

class TodoRepo {
  late Box<Todo> _hive;
  late List<Todo> _box;
  TodoRepo();
  List<Todo> getValue() {
    _hive = Hive.box<Todo>('todos');
    _box = _hive.values.toList();
    return _box;
  }

  List<Todo> addValue(Todo todo) {
    _hive.add(todo);

    return _hive.values.toList();
  }

  List<Todo> removeTodo(String id) {
    print(_hive.values.length);
    _hive.deleteAt(
        _hive.values.toList().indexWhere((element) => element.id == id));
    print(_hive.values.length);

    return _hive.values.toList();
  }

  List<Todo> updateTodo(int index, Todo todo) {
    _hive.putAt(index, todo);
    return _hive.values.toList();
  }

  void deleteAll() {
    _box.clear();
  }
  // Future<void> put(String key, dynamic value) async {
  //   await _box.put(key, value);
  // }

  // dynamic get(String key) {
  //   return _box.get(key);
  // }

  // Future<void> delete(String key) async {
  //   await _box.delete(key);
  // }
}
