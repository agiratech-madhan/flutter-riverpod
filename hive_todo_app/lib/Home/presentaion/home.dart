import 'package:flutter/material.dart';
import 'package:hive_todo_app/Home/presentaion/create.dart';
import 'package:hive_todo_app/Home/presentaion/widgets/categories.dart';
import 'package:hive_todo_app/Home/presentaion/widgets/status_filter.dart';
import 'package:hive_todo_app/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../provider/category_provider.dart';
import '../provider/todo_provider.dart';

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(hiveData);
    debugPrint(provider?.length.toString());
    final data = ref.watch(filteredDataProvider);

    final enabledFilter = ref.watch(enabledFilterProvider);
    final selectedItem = ref.watch(selectedFilterItemProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Todo App "),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40, child: StatusFilter()),
          SizedBox(
              height: 40,
              child: Row(
                mainAxisSize: !(enabledFilter && selectedItem.isNotEmpty)
                    ? MainAxisSize.max
                    : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Categories(),
                  if (enabledFilter && selectedItem.isNotEmpty)
                    Flexible(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: selectedItem.length,
                          itemBuilder: (context, index) {
                            return OutlinedButton(
                                    onPressed: () async {
                                      await ref
                                          .read(categoryListProvider.notifier)
                                          .updateOption(selectedItem[index].id,
                                              value: false);

                                      if (selectedItem.isEmpty) {
                                        ref
                                            .read(
                                                enabledFilterProvider.notifier)
                                            .state = false;
                                      } else {
                                        ref
                                            .read(
                                                enabledFilterProvider.notifier)
                                            .state = true;
                                      }
                                    },
                                    child: Text(selectedItem[index]
                                        .category
                                        .toString()))
                                .py4();
                          }),
                    ),
                ],
              )),
          data.isEmpty
              ? const Center(
                  child: Text("No data"),
                )
              : Expanded(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
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
                                    ref.read(statusProvider.notifier).state =
                                        data[index].status == 'pending'
                                            ? Status.pending
                                            : Status.completed;
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
