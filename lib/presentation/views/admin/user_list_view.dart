import 'package:director_app_tfg/presentation/providers/musician/musician_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserListView extends ConsumerStatefulWidget {
  const UserListView({Key? key}) : super(key: key);

  @override
  UserListViewState createState() => UserListViewState();
}

class UserListViewState extends ConsumerState<UserListView> {

  @override
  void initState() {
    super.initState();
    ref.read(musiciansProvider.notifier).getAllMusicians();
  }

  @override
  Widget build(BuildContext context) {
    final musicians = ref.watch(musiciansProvider);
    
    return musicians.isNotEmpty 
      ? ListView.builder(
        itemCount: musicians.length,
        itemBuilder: (context, index) {
          final musician = musicians[index];
          return Column(
            children: [
              ListTile(
                title: Row(
                  children: [
                    Text(
                      musician.name,
                      style: const TextStyle(
                        fontSize: 22
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.check_circle_outline_outlined,
                        size: 32,
                        color: Colors.green[700],
                      ),
                      onPressed: (){},
                    ),
                  ],
                ),
              ),
              const Divider(),
            ],
          );
        }
      )
    : const Center(
      child: Text(
        "Lista Vacía",
        style: TextStyle(
          color: Colors.grey,
          fontSize: 22
        ),
      ),
    );
  }
}