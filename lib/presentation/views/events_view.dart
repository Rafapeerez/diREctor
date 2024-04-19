import 'package:director_app_tfg/domain/models/enums/event_type_enum.dart';
import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/presentation/providers/event/event_provider.dart';
import 'package:director_app_tfg/presentation/providers/user_provider.dart';
import 'package:director_app_tfg/presentation/widgets/custom_card.dart';
import 'package:director_app_tfg/presentation/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventsView extends ConsumerStatefulWidget {
  const EventsView({super.key});

  @override
  EventsViewState createState() => EventsViewState();
}

class EventsViewState extends ConsumerState<EventsView> {
  @override
  void initState() {
    super.initState();
    ref.read(eventsProvider.notifier).getAllEvents();
  }

  @override
  Widget build(BuildContext context) {
    final eventsProv = ref.read(eventProvider.notifier);
    final events = ref.watch(eventsProvider);
    final userState = ref.watch(userProvider);

    return events.isNotEmpty
      ? Stack(
        children: [
          ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return Column(
                children: [
                  CustomCard(
                    title: event.type.displayName, 
                    isAttendingEvent: true,
                    description: event.location,
                    route: '/home/0/eventsdetails-screen'
                  )
                ],
              );
            },
          ),
          if (userState.isAdmin)
            _CustomElevatedButton(eventsProv: eventsProv, ref: ref)
        ]
      )
      : Stack(
          children: [
            const Center(
              child: Text(
                "No hay eventos",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 22
                ),
              ),
            ),
            if (userState.isAdmin)
              _CustomElevatedButton(eventsProv: eventsProv, ref: ref)
          ] 
      );
  }
}

class _CustomElevatedButton extends StatelessWidget {
  const _CustomElevatedButton({
    required this.eventsProv,
    required this.ref,
  });

  final EventProvider eventsProv;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      icon: Icons.add, 
      onPressed: () async {
        Event event = Event.create(
          type: EventTypeEnum.concierto, 
          date: DateTime.now(), 
          location: "Puente Romano de Cordoba"
        );
    
        await eventsProv.saveEvent(event);
        await ref.watch(eventsProvider.notifier).updateEventsList(event);
      }
    );
  }
}
