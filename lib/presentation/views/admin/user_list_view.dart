import 'package:director_app_tfg/domain/models/enums/instrumet_type_enum.dart';
import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/presentation/providers/musician/musician_provider.dart';
import 'package:director_app_tfg/presentation/widgets/components/custom_submit_and_cancel_buttons.dart';
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
    final musicianProv = ref.read(musicianProvider.notifier);
    final deleteMusicianUseCase = ref.watch(deleteMusicianUseCaseProvider);

    SimpleDialogOption _buildSimpleDialogOption( BuildContext context, MusicianProvider musicianProv, Musician musician, String instrument ) {
      return SimpleDialogOption(
        onPressed: () async {
          await musicianProv.updateMusician(
            Musician(
              email: musician.email, 
              name: musician.name,
              instrument: instrument, 
              isAllowed: true, 
              isAdmin: false,
              fcm: musician.fcm,
              totalEventsAttendance: musician.totalEventsAttendance
            )
          );
          await ref.read(musiciansProvider.notifier).updateNotAllowedList(musician);
          Navigator.of(context).pop();
        },
        child: Text(instrument),
      );
    }
    
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
                        onPressed: (){
                          showDialog(
                            context: context, 
                            builder: (BuildContext context) {
                              return SimpleDialog(
                                title: const Text('Asignar Instrumento'),
                                children: [
                                  _buildSimpleDialogOption(
                                    context, 
                                    musicianProv, 
                                    musician, 
                                    InstrumentTypeEnum.trumpet.displayName
                                  ),
                                  const Divider(),
                                  _buildSimpleDialogOption(
                                    context, 
                                    musicianProv, 
                                    musician, 
                                    InstrumentTypeEnum.bass.displayName
                                  ),
                                  const Divider(),
                                  _buildSimpleDialogOption(
                                    context, 
                                    musicianProv, 
                                    musician, 
                                    InstrumentTypeEnum.cornet.displayName
                                  ),
                                  const Divider(),
                                  _buildSimpleDialogOption(
                                    context, 
                                    musicianProv, 
                                    musician, 
                                    InstrumentTypeEnum.percussion.displayName
                                  ),
                                ],
                              );
                            },
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
                        onPressed: () {
                          showDialog(
                            context: context, 
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                  "¿Está seguro que desea borrar de la lista al usuario?",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                content: SubmitAndCancelButtons(
                                  onCancelPressed: () => Navigator.of(context).pop(), 
                                  onSubmitedPressed: () async {
                                    await deleteMusicianUseCase.execute(musician.email);
                                    await ref.read(musiciansProvider.notifier).updateNotAllowedList(musician);
                                    Navigator.of(context).pop();
                                  }, 
                                )
                              );
                            },
                          );
                        }
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

