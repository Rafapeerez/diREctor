import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/presentation/providers/musician/musician_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
    final musicianProv = ref.read(musicianProvider.notifier);
    
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
                      
                      // Accept Button
                      IconButton(
                        icon: Icon(
                          Icons.check_circle_outline_outlined,
                          size: 32,
                          color: Colors.green[700],
                        ),
                        //TODO: REFACTORIZED
                        onPressed: (){
                          showDialog(
                            context: context, 
                            builder: (BuildContext context) {
                              return SimpleDialog(
                                title: const Text('Asignar Instrumento'),
                                children: [
                                  SimpleDialogOption(
                                    onPressed: () async {
                                      await musicianProv.updateMusician(Musician(
                                        email: musician.email, 
                                        name: musician.name,
                                        instrument: "Trompeta", 
                                        isAllowed: true, 
                                        isAdmin: false,
                                        fcm: musician.fcm
                                      ));
                                      await ref.read(musiciansProvider.notifier).updateNotAllowedList(musician);
                                      context.pop();
                                    },
                                    child: const Text('Trompeta'),
                                  ),
                                  const Divider(),
                                  SimpleDialogOption(
                                    onPressed: () async {
                                      await musicianProv.updateMusician(Musician(
                                        email: musician.email, 
                                        name: musician.name,
                                        instrument: "Bajo", 
                                        isAllowed: true, 
                                        isAdmin: false,
                                        fcm: musician.fcm
                                      ));
                                      await ref.read(musiciansProvider.notifier).updateNotAllowedList(musician);
                                      context.pop();
                                    },
                                    child: const Text('Bajo'),
                                  ),
                                  const Divider(),
                                  SimpleDialogOption(
                                    onPressed: () async {
                                      await musicianProv.updateMusician(Musician(
                                        email: musician.email, 
                                        name: musician.name,
                                        instrument: "Corneta", 
                                        isAllowed: true, 
                                        isAdmin: false,
                                        fcm: musician.fcm
                                      ));
                                      await ref.read(musiciansProvider.notifier).updateNotAllowedList(musician);
                                      context.pop();
                                    },
                                    child: const Text('Corneta'),
                                  ),
                                  const Divider(),
                                  SimpleDialogOption(
                                    onPressed: () async {
                                      await musicianProv.updateMusician(Musician(
                                        email: musician.email, 
                                        name: musician.name,
                                        instrument: "Percusión", 
                                        isAllowed: true, 
                                        isAdmin: false,
                                        fcm: musician.fcm
                                      ));
                                      await ref.read(musiciansProvider.notifier).updateNotAllowedList(musician);
                                      context.pop();
                                    },
                                    child: const Text('Percusión'),
                                  ),
                                ],
                              );
                            }
                          );
                        },
                      ),

                      // Cancel Button
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