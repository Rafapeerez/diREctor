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
        ? Stack(children: [
            ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Column(
                  children: [
                    CustomCard(
                      eventID: event.id,
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
          ])
        : Stack(children: [
            const Center(
              child: Text(
                "No hay eventos",
                style: TextStyle(color: Colors.grey, fontSize: 22),
              ),
            ),
            if (userState.isAdmin)
              _CustomElevatedButton(eventsProv: eventsProv, ref: ref)
          ]);
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
              return AlertDialog(
                title: const Text('Convocatoria'),
                content: EventsForm(eventsProv: eventsProv),
              );
            },
          );
        });
  }
}

class EventsForm extends ConsumerStatefulWidget {
  final EventProvider eventsProv;

  const EventsForm({super.key, required this.eventsProv});

  @override
  EventsFormState createState() => EventsFormState();
}

class EventsFormState extends ConsumerState<EventsForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  EventTypeEnum _type = EventTypeEnum.concierto;

  List<String> options = ['Concierto', 'Salida Procesional'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            //FORM
            //TYPE
            DropdownButtonFormField<String>(
              value: _type.displayName,
              onChanged: (String? newValue) {
                if (newValue! == "concierto") {
                  setState(() {
                    _type = EventTypeEnum.concierto;
                  });
                } else {
                  setState(() {
                    _type = EventTypeEnum.salidaProcesional;
                  });
                }
              },
              items: options.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Selecciona una opción',
              ),
              validator: (value) {
                if (value == null) {
                  return 'Por favor selecciona una opción';
                }
                return null;
              },
            ),
      
            //LOCATION
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'Ingresa una dirección'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor ingresa una dirección';
                }
                return value;
              },
              onSaved: (value) {},
            ),
            const SizedBox(height: 16),
      
            //DURATION
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Ingresa la duración'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor ingresa la duración';
                }
                return value;
              },
              onSaved: (value) {},
            ),
            const SizedBox(height: 16),
      
            //MORE INFO
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'Añadir nota (opcional)'),
              validator: (value) {
                if (value!.isEmpty) {
                  return "";
                }
                return value;
              },
              onSaved: (value) {},
            ),
            const SizedBox(height: 16),
      
            //DATE
            ListTile(
              title: const Text("Ingresa una fecha: "),
              subtitle: Text(
                  "Dia ${_selectedDate.day} del ${_selectedDate.month} a las ${_selectedDate.hour}:${_selectedDate.minute}"),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  final pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(_selectedDate),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      _selectedDate = DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );
                    });
                  }
                }
              },
            ),
      
            const SizedBox(height: 16),
      
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //CANCEL BUTTON
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Cancelar")
                ),
                const Spacer(flex: 1),
      
                //SUBMIT BUTTON
                FilledButton(
                  onPressed: () async {
                    Event event = Event.create(
                      type: EventTypeEnum.concierto,
                      date: DateTime.now(),
                      location: "Puente Romano de Cordoba"
                    );
      
                    await widget.eventsProv.saveEvent(event);
                    await ref.watch(eventsProvider.notifier).updateEventsList(event);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Enviar"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
