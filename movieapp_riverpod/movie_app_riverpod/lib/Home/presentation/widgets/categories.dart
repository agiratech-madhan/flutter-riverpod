import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app_riverpod/Home/controller/provider/providers.dart';

class Categories extends StatefulHookConsumerWidget {
  const Categories({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoriesState();
}

class _CategoriesState extends ConsumerState<Categories> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  // @override
  // void didChangeDependencies() {
  //   ref.watch(genresListProvider);
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(genresListProvider);
//  final data=ref.watch(provider)
    // print(data.genres.length);
    return OutlinedButton.icon(
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
                  Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.70,
                    child: ListView.builder(
                      itemCount: data.genres.length,
                      itemBuilder: (context, index) {
                        // final se = ref.watch(selectedProvider(index));
                        final element = data.genres.elementAt(index);
                        return ListTile(
                          leading: Checkbox(
                            value: element.selected,
                            onChanged: (value) async {
                              print(value);
                              ref
                                  .read(genresListProvider.notifier)
                                  .updateOption(index, value!);
                              print(value);
                            },
                          ),
                          title: Text(element.name),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      icon: const Icon(Icons.sort_sharp),
      label: const Text('Filter'),
    );
  }
}
