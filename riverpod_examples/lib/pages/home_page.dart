import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/app_provider.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final data = ref.watch(labProvider);
    final data = ref.watch(labControllerProvider);
    final isLoading = ref.watch(isLoadingLabProvider);

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
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : data.whenOrNull(
                error: (e, t) => Text("Error Occured"),
                data: (data) {
                  return Column(
                    children: [
                      // data.when(
                      //     data: (data) {
                      Expanded(
                          child: ListView.builder(
                              itemCount: data
                                  ?.nRhLnv4P2FRwQuqCu02?.data?.results?.length,
                              itemBuilder: (context, index) {
                                final labData = data?.nRhLnv4P2FRwQuqCu02?.data
                                    ?.results?[index];
                                return ListTile(
                                  leading: CircleAvatar(
                                    child:
                                        Text(labData!.name![index].toString()),
                                  ),
                                  title: Text(labData.email.toString()),
                                );
                              }))
                      // },
                      // error: (error, stackTrace) => const Text('Error'),
                      // loading: () => const Center(
                      //       child: CircularProgressIndicator(),
                      //     ))

                      ,
                    ],
                  );
                },
              ));
  }
}
