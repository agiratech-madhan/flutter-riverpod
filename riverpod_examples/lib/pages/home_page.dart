import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/app_provider.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(photoProvider);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Photo data'),
          actions: [
            // IconButton(
            //     onPressed: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => const TodoPage()));
            //     },
            //     icon: const Icon(Icons.arrow_forward_ios))
          ],
        ),
        body: Column(
          children: [
            data.when(
                data: (data) {
                  return Expanded(
                      child: ListView.builder(
                          itemCount: data.photos!.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(data
                                    .photos![index].thumbnailUrl
                                    .toString()),
                              ),
                              title: Text(data.photos![index].title.toString()),
                            );
                          }));
                },
                error: (error, stackTrace) => const Text('Error'),
                loading: () => const Center(
                      child: CircularProgressIndicator(),
                    )),
          ],
        ));
  }
}
