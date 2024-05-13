import 'package:director_app_tfg/domain/models/enums/holy_week_name_enum.dart';
import 'package:director_app_tfg/domain/models/holy_week_event.dart';
import 'package:director_app_tfg/presentation/providers/event/holy_week_event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomHolyWeekCard extends ConsumerStatefulWidget {
  final HolyWeekEvent? holyWeekEvent;
  final HolyWeekNameEnum name;
  final String image;
  final String route;

  const CustomHolyWeekCard({
    super.key,
    this.holyWeekEvent,
    required this.name,
    this.route = "",
    required this.image,
  });

  @override
  CustomCardState createState() => CustomCardState();
}

class CustomCardState extends ConsumerState<CustomHolyWeekCard> {
  @override
  Widget build(BuildContext context) {
    final selectedHolyWeekEventProv = ref.read(selectedHolyWeekEventProvider.notifier);

    return InkWell(
      onTap: () {
        if (widget.holyWeekEvent == null) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Descanso'),
                content: const Text('Hoy tenemos día de decanso.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cerrar'),
                  ),
                ],
              );
            },
          );
        }
        else {
          context.go(widget.route);
          selectedHolyWeekEventProv.state = widget.holyWeekEvent;
        }
      },
      child: Card(
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        elevation: 10,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Column(
            children: [
              Image.asset(widget.image),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      widget.name.displayName,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.holyWeekEvent?.location ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 5)
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