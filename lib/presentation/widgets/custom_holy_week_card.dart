import 'package:director_app_tfg/domain/models/holy_week_event.dart';
import 'package:director_app_tfg/presentation/providers/holy_week_event/holy_week_event_provider.dart';
import 'package:director_app_tfg/presentation/providers/user_provider.dart';
import 'package:director_app_tfg/presentation/widgets/holy_week_event/form_holy_week_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomHolyWeekCard extends ConsumerStatefulWidget {
  final HolyWeekEvent? holyWeekEvent;

  const CustomHolyWeekCard({
    super.key,
    this.holyWeekEvent,
  });

  @override
  CustomCardState createState() => CustomCardState();
}

class CustomCardState extends ConsumerState<CustomHolyWeekCard> {
  @override
  Widget build(BuildContext context) {
    final selectedHolyWeekEventProv = ref.read(selectedHolyWeekEventProvider.notifier);
    final userState = ref.watch(userProvider);

    return InkWell(
      onTap: () {
        if ( widget.holyWeekEvent!.location.isEmpty && widget.holyWeekEvent!.imageURL.contains('Descanso')) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Descanso'),
                content: const Text('Hoy tenemos día de descanso.'),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cerrar'),
                      ),
                      userState.isAdmin 
                        ? TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Nuevo contrato'),
                                  content: HolyWeekEventsForm(holyWeekEventSelected: widget.holyWeekEvent),
                                );
                              },
                            );                         
                          },
                          child: const Text('Cambiar'),
                        )
                        : const SizedBox()
                    ],
                  ),
                ],
              );
            },
          );
        }
        else {
          context.go("/home/1/holyweekdetails-screen");
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
              AspectRatio(
                aspectRatio: 3.5 / 1,
                child: Image.network(
                  widget.holyWeekEvent!.imageURL,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      widget.holyWeekEvent!.name.displayName,
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