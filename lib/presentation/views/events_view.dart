import 'package:director_app_tfg/presentation/providers/event/event_provider.dart';
import 'package:director_app_tfg/presentation/widgets/custom_card.dart';
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
    final events = ref.watch(eventsProvider);

    return events.isNotEmpty
      ? ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return Column(
              children: [
                CustomCard(
                  title: event.type.toString(), 
                  route: '/home/0/eventsdetails-screen'
                )
              ],
            );
          },
        )
      : const Center(
        child: Text(
          "No hay eventos",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 22
          ),
        ),
      );
  }
}
