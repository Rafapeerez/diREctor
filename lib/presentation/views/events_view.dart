import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/presentation/providers/event/event_provider.dart';
import 'package:director_app_tfg/presentation/providers/user_provider.dart';
import 'package:director_app_tfg/presentation/widgets/custom_event_card.dart';
import 'package:director_app_tfg/presentation/widgets/components/custom_elevated_button.dart';
import 'package:director_app_tfg/presentation/widgets/events/form_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventsView extends ConsumerStatefulWidget {
  const EventsView({super.key});

  @override
  EventsViewState createState() => EventsViewState();
}

class EventsViewState extends ConsumerState<EventsView> {
  final Map<String, bool> _hasConfirmedMap = {};
  List<Event> _events = [];

  @override
  void initState() {
    super.initState();
    _checkConfirmations();
  }

  Future<void> _checkConfirmations() async {
    final eventsNotifier = ref.read(eventsProvider.notifier);
    await eventsNotifier.getAllEvents();
    
    final userState = ref.read(userProvider);
    _events = ref.read(eventsProvider);

    for (final event in _events) {
      final bool hasConfirmed = await ref.read(attendanceProvider.notifier).hasConfirmed(userState.user!.email!, event.id);
      if (mounted) {
        setState(() {
          _hasConfirmedMap[event.id] = hasConfirmed;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final eventsProv = ref.read(eventProvider.notifier);
    final events = ref.watch(eventsProvider);
    final userState = ref.watch(userProvider);
    final bool hasFutureEvents = events.any((event) => event.date.isAfter(DateTime.now()));

    return _events.isNotEmpty && hasFutureEvents
        ? Stack(
            children: [
              ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  final bool hasConfirmed = _hasConfirmedMap[event.id] ?? false;

                  if (event.date.isBefore(DateTime.now())) {
                    return const SizedBox();
                  }
                  return Column(
                    children: [
                      event.type.displayName == "Concierto" 
                        ? CustomEventCard(
                          event: event,
                          hasConfirmed: hasConfirmed,
                          isAttendingEvent: true,
                          image: 'lib/config/assets/images/Concierto.jpg',
                          route: '/home/0/eventsdetails-screen',
                        )
                        : CustomEventCard(
                          event: event,
                          hasConfirmed: hasConfirmed,
                          isAttendingEvent: true,
                          image: 'lib/config/assets/images/SalidasProcesionales.jpg',
                          route: '/home/0/eventsdetails-screen',
                        )
                    ],
                  );
                },
              ),
              if (userState.isAdmin) _CustomElevatedButton(eventsProv: eventsProv, ref: ref)
            ],
          )
        : Stack(
            children: [
              const Center(
                child: Text(
                  "No hay eventos",
                  style: TextStyle(color: Colors.grey, fontSize: 22),
                ),
              ),
              if (userState.isAdmin) _CustomElevatedButton(eventsProv: eventsProv, ref: ref)
            ],
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
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text('Convocatoria'),
              content: EventsForm(),
            );
          },
        );
      }
    );
  }
}
