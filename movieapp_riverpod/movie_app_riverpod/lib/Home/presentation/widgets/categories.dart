import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app_riverpod/Home/controller/provider/providers.dart';

class Categories extends HookConsumerWidget {
  const Categories({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sets = ref.watch(selectedGenresListProvider);
    final filteredDataProvider = ref.watch(appliedFilter);
    return SizedBox(
      height: 70,
      child: Row(
        mainAxisAlignment: filteredDataProvider
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
              onPressed: () {
                if (sets.isEmpty) {
                  ref.read(appliedFilter.notifier).state = false;
                }
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
                                        ref
                                            .read(genresListProvider.notifier)
                                            .updateOption(element.id, value!);
                                      },
                                    ),
                                    title: Text(element.name),
                                  );
                                },
                              ),
                            );
                          }),
                          Container(
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 40,
                                  width: 80,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        ref
                                            .read(movieControllerProvider
                                                .notifier)
                                            .updateFilter();
                                        ref.read(appliedFilter.notifier).state =
                                            true;

                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Apply')),
                                ),
                                Container(
                                  height: 40,
                                  width: 80,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        if (!filteredDataProvider) {
                                          ref.invalidate(genresListProvider);
                                        }
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancel')),
                                ),
                              ],
                            ),
                          )
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
          if (filteredDataProvider)
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
                          onPressed: () async {
                            ref
                                .read(genresListProvider.notifier)
                                .updateOption(element.id, false);

                            final s = ref.watch(selectedGenresListProvider);
                            await ref
                                .read(movieControllerProvider.notifier)
                                .updateFilter();
                            if (s.isNotEmpty) {
                              ref.read(filterSearchProvider.notifier).state =
                                  true;
                            } else {
                              ref.read(filterSearchProvider.notifier).state =
                                  false;
                              if (!filteredDataProvider) {
                                ref.invalidate(genresListProvider);
                              }

                              ref.read(appliedFilter.notifier).state = false;
                            }
                          },
                          child: Text(s[index].name,
                              textAlign: TextAlign.justify)),
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
