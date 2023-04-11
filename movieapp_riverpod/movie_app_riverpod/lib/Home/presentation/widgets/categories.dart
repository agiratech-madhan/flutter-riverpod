import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app_riverpod/Home/controller/provider/providers.dart';

class Categories extends HookConsumerWidget {
  const Categories({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sets = ref.watch(selectedGenresListProvider);
    return SizedBox(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 50,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
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
                                children: const [
                                  SizedBox(
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
                                      onChanged: (value) async {
                                        await ref
                                            .read(genresListProvider.notifier)
                                            .updateOption(element.id, value!);
                                        final sests = ref
                                            .watch(selectedGenresListProvider);
                                        if (sests.isNotEmpty) {
                                          ref
                                              .read(
                                                  filterSearchProvider.notifier)
                                              .state = true;
                                        } else {
                                          ref
                                              .read(
                                                  filterSearchProvider.notifier)
                                              .state = false;
                                        }
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
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: sets.length,
                itemBuilder: (context, index) {
                  final data = ref.watch(selectedGenresListProvider);
                  final element = data.elementAt(index);
                  final s = sets.toList();
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            foregroundColor: Colors.white),
                        onPressed: () {
                          ref
                              .read(genresListProvider.notifier)
                              .updateOption(element.id, false);
                          final s = ref.watch(selectedGenresListProvider);
                          if (s.isNotEmpty) {
                            ref.read(filterSearchProvider.notifier).state =
                                true;
                          } else {
                            ref.read(filterSearchProvider.notifier).state =
                                false;
                          }
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
