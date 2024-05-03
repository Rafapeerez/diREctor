import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/presentation/providers/event/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

//TODO: MODIFICAR EL CUSTOMCARD PARA QUE EL PROVIDER DEL EVENTSELECTED SEA UN EVENT ENTERO Y NO EL ID

class CustomCard extends ConsumerStatefulWidget {
  final Event event;
  final String image;
  final bool isAttendingEvent;
  final String route;

  const CustomCard({
    super.key,
    required this.event,
    required this.route,
    this.image = "",
    this.isAttendingEvent = false,
  });

  @override
  CustomCardState createState() => CustomCardState();
}

class CustomCardState extends ConsumerState<CustomCard> {
  @override
  Widget build(BuildContext context) {
    final selectedEventProv = ref.read(selectedEventProvider.notifier);

    return InkWell(
      onTap: () {
        context.go(widget.route);
        selectedEventProv.state = widget.event;
      },
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          elevation: 10,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Column(
              children: [
                widget.image != ""
                    ? Image.asset(widget.image)
                    : Container(color: Colors.grey.shade700, height: 60),
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
                          ? _DecitionAttendingButton()
                          : const SizedBox(height: 5)
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}

class _DecitionAttendingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FilledButton(
          onPressed: () {},
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.green),
          ),
          child: const Text("Asisto"),
        )
      ],
    );
  }
}
