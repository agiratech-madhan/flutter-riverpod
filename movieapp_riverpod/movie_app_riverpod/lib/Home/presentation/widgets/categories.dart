import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app_riverpod/Home/controller/provider/providers.dart';

class Categories extends HookConsumerWidget {
  const Categories({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sets = ref.watch(filterProvider);

    return SizedBox(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 50,
            child: OutlinedButton.icon(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  isDismissible: true,
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: Navigator.of(context).pop,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    child: Icon(
                                      Icons.cancel_presentation_sharp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          HookConsumer(builder: (context, r, child) {
                            final data = r.watch(genresListProvider);
                            return Container(
                              color: Colors.white,
                              height: MediaQuery.of(context).size.height * 0.70,
                              child: ListView.builder(
                                itemCount: data.genres.length,
                                itemBuilder: (context, index) {
                                  final element = data.genres.elementAt(index);
                                  return ListTile(
                                    leading: Checkbox(
                                      value: element.selected,
                                      onChanged: (value) {
                                        print(ref
                                            .watch(genresListProvider)
                                            .genres[index]
                                            .selected);
                                        ref
                                            .read(genresListProvider.notifier)
                                            .updateOption(element.id, value!);
                                        print(element.id);
                                        print(ref
                                            .watch(genresListProvider)
                                            .genres[index]
                                            .selected);
                                      },
                                    ),
                                    title: Text(element.name),
                                  );
                                },
                              ),
                            );
                          })
                        ],
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.sort_sharp),
              label: const Text('Filter'),
            ),
          ),
          Expanded(
            // flex: 1,
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: sets.length,
                itemBuilder: (context, index) {
                  final data = ref.watch(filterProvider);
                  final element = data.elementAt(index);
                  final s = sets.toList();
                  return SizedBox(
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white),
                        onPressed: () {
                          // print(element.id);
                          ref
                              .read(genresListProvider.notifier)
                              .updateOption(element.id, false);
                        },
                        child:
                            Text(s[index].name, textAlign: TextAlign.justify)),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
