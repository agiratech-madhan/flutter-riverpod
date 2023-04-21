// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:hive_todo_app/Home/model/todo_model.dart';
import 'package:hive_todo_app/utils.dart';

import '../provider/todo_provider.dart';

final selectedRadioProvider = StateProvider<int>((ref) => 0);

class EditScreen extends StatefulHookConsumerWidget {
  const EditScreen({
    Key? key,
    required this.description,
    required this.title,
    required this.isNew,
    required this.id,
    this.status,
    required this.index,
  }) : super(key: key);
  final String description;
  final String title;
  final bool isNew;
  final String id;
  final Status? status;
  final int index;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditScreenState();
}

class _EditScreenState extends ConsumerState<EditScreen> {
  final titleController = TextEditingController();
  final categoryController = TextEditingController();

  @override
  void initState() {
    if (!widget.isNew) {
      titleController.text = widget.title;
      categoryController.text = widget.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(statusProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Edit Screen"),
      ),
      body: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black54,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black54,
                ),
              ),
              hintText: ' Enter title',
            ),
          ),
          TextField(
            controller: categoryController,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black54,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black54,
                ),
              ),
              hintText: ' Enter category',
            ),
          ).py12(),
          const SizedBox(
            height: 30,
          ),
          RadioListTile<Status>(
              title: const Text("Completed"),
              value: Status.completed,
              groupValue: status,
              onChanged: (v) {
                ref.read(statusProvider.notifier).state = v!;
              }),
          RadioListTile<Status>(
            title: const Text("Pending"),
            value: Status.pending,
            groupValue: status,
            onChanged: (v) {
              ref.read(statusProvider.notifier).state = v!;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  if (widget.isNew) {
                    ref.read(hiveData.notifier).addTodo(
                          Todo(
                            title: titleController.text,
                            createdAt: DateFormat("d MMM yyyy:h:ma")
                                .format(DateTime.now()),
                            status: status.status,
                            description: categoryController.text,
                          ),
                        );
                  } else {
                    ref.read(hiveData.notifier).updateTodo(
                          widget.index,
                          Todo(
                            title: titleController.text,
                            createdAt: DateFormat("d MMM yyyy:h:ma")
                                .format(DateTime.now()),
                            status: status.name,
                            description: categoryController.text,
                          ),
                        );
                  }
                  ref.invalidate(statusProvider);
                  Navigator.pop(context);
                },
                child: Text(
                  widget.isNew ? 'Create' : 'Update',
                ),
              ),
            ],
          )
        ],
      ).p(10),
    );
  }
}
