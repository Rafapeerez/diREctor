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
    ref.read(musiciansProvider.notifier).getNotAllowedMusicians();
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
              Tooltip(
                message: musician.name,
                child: ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(8,2,2,2),
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          musician.name,
                          style: const TextStyle(
                            fontSize: 22,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: Icon(
                          Icons.check_circle_outline_outlined,
                          size: 32,
                          color: Colors.green[700],
                        ),
                        onPressed: (){},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.cancel_outlined,
                          size: 32,
                          color: Colors.red[700],
                        ),
                        onPressed: (){},
                      ),
                    ],
                  ),
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