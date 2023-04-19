import 'package:flutter/material.dart';
import 'package:hive_todo_app/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:hive_todo_app/Home/model/todo_model.dart';
import '../provider/todo_provider.dart';

class EditScreen extends StatefulHookConsumerWidget {
  const EditScreen({
    Key? key,
    required this.description,
    required this.title,
    required this.isNew,
    required this.id,
    this.status,
  }) : super(key: key);
  final String description;
  final String title;
  final bool isNew;
  final String id;
  final Status? status;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditScreenState();
}

class _EditScreenState extends ConsumerState<EditScreen> {
  final titleController = TextEditingController();
  final desController = TextEditingController();

  @override
  void initState() {
    if (!widget.isNew) {
      titleController.text = widget.title;
      desController.text = widget.description;
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
            controller: desController,
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
              hintText: ' Enter Description',
            ),
          ).py12(),
          const SizedBox(
            height: 30,
          ),
          RadioListTile<Status>(
              title: const Text("Completed"),
              value: Status.completed,
              groupValue: widget.status ?? status,
              onChanged: (v) {
                ref.read(statusProvider.notifier).state = v!;
              }),
          RadioListTile<Status>(
              title: const Text("Pending"),
              value: Status.pending,
              groupValue: widget.status ?? status,
              onChanged: (v) {
                ref.read(statusProvider.notifier).state = v!;
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
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
                    ref.read(todoDaTaProvider.notifier).addTodo(
                          Todo(
                            title: titleController.text,
                            createdAt: DateFormat(" d MMM yyyy")
                                .format(DateTime.now()),
                            status: status.status,
                            description: desController.text,
                          ),
                        );
                  } else {
                    ref.read(todoDaTaProvider.notifier).updateTodo(
                          widget.id,
                          Todo(
                            title: titleController.text,
                            createdAt: DateFormat(" d MMM yyyy")
                                .format(DateTime.now()),
                            status: status.name,
                            description: desController.text,
                          ),
                        );
                    ref.invalidate(statusProvider);
                  }
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
