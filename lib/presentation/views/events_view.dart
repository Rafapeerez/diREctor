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
  bool _isCheckingConfirmations = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkConfirmations(ref.read(eventsProvider));
    });
  }

  Future<void> _checkConfirmations(List<Event> events) async {
    if (_isCheckingConfirmations) return;
    _isCheckingConfirmations = true;

    final userState = ref.read(userProvider);
    final confirmations = ref.read(confirmationsProvider.notifier);

    for (final event in events) {
      if (!mounted) break;
      final bool hasConfirmed = await ref.read(attendanceProvider.notifier).hasConfirmed(userState.user!.email!, event.id);
      if (mounted) {
        confirmations.setConfirmation(event.id, hasConfirmed);
      }
    }

    if (mounted) {
      setState(() {
        _isCheckingConfirmations = false;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final eventsProv = ref.read(eventProvider.notifier);
    final events = ref.watch(eventsProvider);
    final userState = ref.watch(userProvider);
    final bool hasFutureEvents = events.any((event) => event.date.isAfter(DateTime.now()));
    final confirmations = ref.watch(confirmationsProvider);

    ref.listen<List<Event>>(eventsProvider, (previous, next) {
      if (previous != next) {
        _checkConfirmations(next);
      }
    });
    
    return events.isNotEmpty && hasFutureEvents
        ? Stack(
            children: [
              ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  final bool hasConfirmed = confirmations[event.id] ?? false;

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
