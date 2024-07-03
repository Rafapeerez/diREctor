import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/domain/models/march.dart';
import 'package:director_app_tfg/presentation/providers/event/event_provider.dart';
import 'package:director_app_tfg/presentation/providers/march/march_provider.dart';
import 'package:director_app_tfg/presentation/widgets/events/form_event.dart';
import 'package:director_app_tfg/presentation/widgets/march/form_march.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PopUpMenuButton extends ConsumerWidget {
  final Event? eventSelected;
  final March? marchSelected;

  const PopUpMenuButton({
    super.key, 
    this.eventSelected,
    this.marchSelected
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deleteEventUseCase = ref.watch(deleteEventUseCaseProvider);
    final deleteMarchUseCase = ref.watch(deleteMarchUseCaseProvider);

    return PopupMenuButton<String>(
      onSelected: (String choice) async {
        if (choice == 'Editar') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              if ( eventSelected != null ) {
                return AlertDialog(
                  title: const Text('Editar Convocatoria'),
                  content: EventsForm(eventSelected: eventSelected),
                );
              }
              else {
                return AlertDialog(
                  title: const Text('Editar Marcha'),
                  content: MarchsForm(marchSelected: marchSelected),
                );
              }
            },
          );
        } else if (choice == 'Eliminar') {
          if (eventSelected != null) {
            await deleteEventUseCase.execute(eventSelected!.id);
            await ref.read(eventsProvider.notifier).updateEventsListAfterDelete(eventSelected!.id);
            context.go("/home/0");
          }
          else if ( marchSelected != null ) {
            await deleteMarchUseCase.execute(marchSelected!.id);
            await ref.read(marchsProvider.notifier).updateMarchsListAfterDelete(marchSelected!.id);
            context.go("/home/2");
          }
        }
      },
      itemBuilder: (BuildContext context) => const <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'Editar',
          child: Text('Editar'),
        ),
        PopupMenuItem<String>(
          value: 'Eliminar',
          child: Text('Eliminar'),
        ),
      ],
      icon: const Icon(Icons.more_vert),
    );
  }
}