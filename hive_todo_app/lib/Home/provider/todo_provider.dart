import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../controller/todo_controller.dart';
import '../model/todo_model.dart';
import '../../utils.dart';
import '../repo/todorepo.dart';
import 'category_provider.dart';

final statusProvider = StateProvider<Status>((ref) => Status.all);
final filterProvider = StateProvider<Status>((ref) => Status.all);

final filteredDataProvider = Provider<List<Todo>>(
  (ref) {
    final selectedItem = ref.watch(selectedFilterItemProvider);
    final showFilter = ref.watch(enabledFilterProvider);
    final hiveDatas = ref.watch(hiveData);
    List<Todo> categoryData = hiveDatas!.where((e) {
      final x = selectedItem.isNotEmpty ? selectedItem.first.category : '';
      return e.description.contains(x.toString());
    }).toList();
    final data =
        (selectedItem.isNotEmpty && showFilter) ? categoryData : hiveDatas;
    final status = ref.watch(filterProvider);
    switch (status) {
      case Status.completed:
        return data.where((todo) {
          // print(todo.status);
          return todo.status == 'completed';
        }).toList();
      case Status.pending:
        return data.where((todo) => todo.status == 'pending').toList();
      case (Status.all):
        return data.toList();
    }
  },
);
final providerHive = Provider<TodoRepo>((ref) => TodoRepo());
final hiveData =
    StateNotifierProvider<TodoHive, List<Todo>?>((ref) => TodoHive(ref));
