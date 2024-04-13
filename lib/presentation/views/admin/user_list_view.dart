import 'package:director_app_tfg/presentation/providers/musician/musician_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserListView extends ConsumerWidget {
  const UserListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final musicianStream = ref.watch(musiciansProvider);

    return const Placeholder();
    // return ListView.builder(
    //   itemBuilder: (context, index) {
    //     musicianStream.elementAt(index).then(
    //       (musician) => ListTile(
    //         title: Text('Nombre: ${musician.name}'),
    //       ),
    //     );
    //   },
    // );
  }
}
