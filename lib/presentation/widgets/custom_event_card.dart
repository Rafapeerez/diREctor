import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/presentation/providers/event/event_provider.dart';
import 'package:director_app_tfg/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomEventCard extends ConsumerStatefulWidget {
  final Event event;
  final bool isAttendingEvent;
  final String route;

  const CustomEventCard({
    super.key,
    required this.event,
    required this.route,
    this.isAttendingEvent = false,
  });

  @override
  CustomCardState createState() => CustomCardState();
}

class CustomCardState extends ConsumerState<CustomEventCard> {
  @override
  Widget build(BuildContext context) {
    final selectedEventProv = ref.read(selectedEventProvider.notifier);
    final userState = ref.watch(userProvider);
    final hasUserVote = selectedEventProv.state.attendance.contains(userState.user);
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () {
        context.go(widget.route);
        selectedEventProv.state = widget.event;
      },
      child: Card(
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        elevation: 10,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Column(
            children: [
              Container(
                color: Colors.grey.shade700, 
                height: 60
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      widget.event.type.displayName,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.event.location,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    widget.isAttendingEvent
                      ? hasUserVote
                          ? const _DecitionAttendingButton(
                              backgroundColor: Colors.green,
                              text: "Asisto",
                              textColor: Colors.black,
                            )
                          : _DecitionAttendingButton(
                              backgroundColor: colors.primary,
                              text: "Vota asistencia...",
                              textColor: Colors.white,
                            )
                      : const SizedBox(height: 5)
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}

class _DecitionAttendingButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color textColor;
  final Color backgroundColor;

  const _DecitionAttendingButton({
    this.onPressed,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FilledButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          ),
          child: Text(
            text, 
            style: TextStyle(
              color: textColor    
            )
          ),
        ),
      ],
    );
  }
}
