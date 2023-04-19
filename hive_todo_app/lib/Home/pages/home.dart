import 'package:flutter/material.dart';
import 'package:hive_todo_app/Home/model/todo_model.dart';
import 'package:hive_todo_app/Home/pages/create.dart';
import 'package:hive_todo_app/Home/pages/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

import 'controller/todo_controller.dart';

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(dataProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Todo App "),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40, child: StatusFilter()),
          data.todos.isEmpty
              ? const Center(
                  child: Text("No data"),
                )
              : Expanded(
                  child: ListView.builder(
                      itemCount: data.todos.length,
                      itemBuilder: (context, index) {
                        // print(data.todos[index].id);
                        return ListTile(
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data.todos[index].title,
                                maxLines: 1,
                              ),
                              Text(
                                data.todos[index].createdAt,
                                maxLines: 1,
                              ),
                            ],
                          ),
                          subtitle: Text(
                            data.todos[index].description,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    print(data.todos[index].status);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditScreen(
                                                  isNew: false,
                                                  id: data.todos[index].id,
                                                  description: data
                                                      .todos[index].description,
                                                  title:
                                                      data.todos[index].title,
                                                  status: data.todos[index]
                                                              .status ==
                                                          'Pending'
                                                      ? Status.pending
                                                      : Status.completed,
                                                )));
                                  },
                                  icon: const Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () {
                                    ref.read(dataProvider).removeTodo(index);
                                  },
                                  icon:
                                      const Icon(Icons.delete_outline_rounded)),
                            ],
                          ),
                        );
                      }),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.invalidate(statusProvider);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditScreen(
                        isNew: true,
                        id: '',
                        description: '',
                        title: '',
                      )));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class StatusFilter extends ConsumerWidget {
  const StatusFilter({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(filterProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: Status.values
          .map((type) => InkWell(
                  child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    backgroundColor:
                        status == type ? Colors.purple.withOpacity(0.7) : null,
                    foregroundColor: status != type
                        ? Colors.purple.withOpacity(0.7)
                        : Colors.white),
                onPressed: () {
                  ref.read(statusProvider.notifier).state = type;
                },
                child: Text(
                  type.name,
                ),
              )))
          .toList(),
    );
  }
}
/**Chip(
                  label: Text(
                    "${type.name}",
                  ),
                  backgroundColor: type == status ? Colors.blue : null,
                ), */