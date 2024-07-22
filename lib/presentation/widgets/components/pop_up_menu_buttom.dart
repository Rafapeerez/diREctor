import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/domain/models/holy_week_event.dart';
import 'package:director_app_tfg/domain/models/march.dart';
import 'package:director_app_tfg/presentation/providers/event/event_provider.dart';
import 'package:director_app_tfg/presentation/providers/holy_week_event/holy_week_event_provider.dart';
import 'package:director_app_tfg/presentation/providers/march/march_provider.dart';
import 'package:director_app_tfg/presentation/widgets/events/form_event.dart';
import 'package:director_app_tfg/presentation/widgets/holy_week_event/form_holy_week_event.dart';
import 'package:director_app_tfg/presentation/widgets/march/form_march.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PopUpMenuButton extends ConsumerWidget {
  final Event? eventSelected;
  final March? marchSelected;
  final HolyWeekEvent? holyWeekEvent;

  const PopUpMenuButton({
    super.key, 
    this.eventSelected,
    this.marchSelected,
    this.holyWeekEvent
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deleteEventUseCase = ref.watch(deleteEventUseCaseProvider);
    final deleteMarchUseCase = ref.watch(deleteMarchUseCaseProvider);
    final changeToRestDayUseCase = ref.watch(changeToRestDayUseCaseProvider);

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
              if ( holyWeekEvent != null ) {
                return AlertDialog(
                  title: Text(holyWeekEvent!.name.displayName),
                  content: HolyWeekEventsForm(holyWeekEventSelected: holyWeekEvent),
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
            ref.read(eventsProvider.notifier).updateEventsListAfterDelete(eventSelected!.id);
            context.go("/home/0");
          }
          else if ( marchSelected != null ) {
            await deleteMarchUseCase.execute(marchSelected!.id);
            await ref.read(marchsProvider.notifier).updateMarchsListAfterDelete(marchSelected!.id);
            context.go("/home/2");
          }
        } else if (choice == 'Descanso') {
          await changeToRestDayUseCase.execute(holyWeekEvent!);
          context.go("/home/1");
        }
      },
      itemBuilder: (BuildContext context) {
        List<PopupMenuEntry<String>> items = <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'Editar',
            child: Text('Editar'),
          ),
        ];
        if (holyWeekEvent == null) {
          items.add(
            const PopupMenuItem<String>(
              value: 'Eliminar',
              child: Text('Eliminar'),
            ),
          );
        }
        else {
          items.add(
            const PopupMenuItem<String>(
              value: 'Descanso',
              child: Text('Descanso'),
            ),
          );
        }
        return items;
      },
      icon: const Icon(Icons.more_vert),
    );
  }
}