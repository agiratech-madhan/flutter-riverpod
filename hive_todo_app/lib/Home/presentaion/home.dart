import 'package:flutter/material.dart';
import 'package:hive_todo_app/Home/model/todo_model.dart';
import 'package:hive_todo_app/Home/presentaion/create.dart';
import 'package:hive_todo_app/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../controller/todo_controller.dart';
import '../provider/todo_provider.dart';
import '../repo/todorepo.dart';

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(hiveData);
    print(provider?.length);
    final data = ref.watch(filteredDataProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Todo App "),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40, child: StatusFilter()),
          data.isEmpty
              ? const Center(
                  child: Text("No data"),
                )
              : Expanded(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        // print(data[index].id);
                        return ListTile(
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data[index].title,
                                maxLines: 1,
                              ),
                              Text(
                                data[index].createdAt.substring(0, 11),
                                maxLines: 1,
                              ),
                            ],
                          ),
                          subtitle: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data[index].description,
                              ),
                              Text(
                                data[index].createdAt.substring(12),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    // print(data[index].status);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditScreen(
                                                  isNew: false,
                                                  id: data[index].id,
                                                  index: index,
                                                  description:
                                                      data[index].description,
                                                  title: data[index].title,
                                                  status: data[index].status ==
                                                          'pending'
                                                      ? Status.pending
                                                      : Status.completed,
                                                )));
                                  },
                                  icon: const Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () {
                                    ref
                                        .read(hiveData.notifier)
                                        .removeTodo(data[index].id);
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
              builder: (context) => const EditScreen(
                isNew: true,
                id: '',
                description: '',
                title: '',
                index: 0,
              ),
            ),
          );
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
                  ref.read(filterProvider.notifier).state = type;
                },
                child: Text(
                  type.name,
                ),
              )))
          .toList(),
    );
  }
}
