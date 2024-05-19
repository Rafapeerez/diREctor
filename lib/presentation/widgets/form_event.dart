import 'package:director_app_tfg/config/helpers/capitalize_string_helper.dart';
import 'package:director_app_tfg/domain/models/enums/event_type_enum.dart';
import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/presentation/providers/event/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventsForm extends ConsumerStatefulWidget {

  final Event? eventSelected;

  const EventsForm({
    super.key,
    this.eventSelected
  });

  @override
  EventsFormState createState() => EventsFormState();
}

class EventsFormState extends ConsumerState<EventsForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  EventTypeEnum _type = EventTypeEnum.concierto;
  Duration _duration = const Duration();
  String _location = "";
  String _moreInfo = "";

  List<String> options = ['Concierto', 'Salida Procesional'];

  @override
  void initState() {
    super.initState();
    if (widget.eventSelected != null) {
      // Initialize with existing event data
      _selectedDate = widget.eventSelected!.date;
      _type = widget.eventSelected!.type;
      _duration = widget.eventSelected!.duration;
      _location = widget.eventSelected!.location;
      _moreInfo = widget.eventSelected!.moreInformation;
    } else {
      // Initialize with default values
      _selectedDate = DateTime.now();
      _type = EventTypeEnum.concierto;
      _duration = const Duration();
      _location = "";
      _moreInfo = "";
    }
  }

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
              items: options.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Selecciona una opción',
              ),
              onChanged: (String? newValue) {
                if (newValue! == "Concierto") {
                  setState(() {
                    _type = EventTypeEnum.concierto;
                  });
                } else {
                  setState(() {
                    _type = EventTypeEnum.salidaProcesional;
                  });
                }
              },
            ),

            //LOCATION
            TextFormField(
              initialValue: _location,
              decoration: const InputDecoration(
                labelText: 'Ingresa una dirección',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor ingresa una dirección';
                }
                return null;
              },
              onChanged: (value) => setState(() => _location = CapitalizeString().capitalizeString(value))
            ),
            const SizedBox(height: 16),

            //DURATION
            TextFormField(
              initialValue: _duration.inHours.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Ingresa la duración (horas)',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor ingresa la duración';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  try {
                    final hours = int.parse(value);
                    setState(() {
                      _duration = Duration(hours: hours);
                    });
                  } catch (e) {
                    setState(() {
                      _duration = Duration.zero;
                    });
                  }
                });
              },
            ),
            const SizedBox(height: 16),

            //MORE INFO
            TextFormField(
              initialValue: _moreInfo,
              decoration: const InputDecoration(labelText: 'Añadir nota (opcional)'),
              onChanged: (value) => setState(() => _moreInfo = value),
            ),
            const SizedBox(height: 16),

            //DATE
            ListTile(
              title: const Text("Ingresa una fecha: "),
              subtitle: Text("Dia ${_selectedDate.day} del ${_selectedDate.month} a las ${_selectedDate.hour}:${_selectedDate.minute}"),
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

            //SUBMIT AND CANCEL BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Cancelar")
                ),
                const Spacer(flex: 1),

                FilledButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (widget.eventSelected != null) {
                        // Update existing event
                        Event updatedEvent = Event.update(
                          uuid: widget.eventSelected!.id, 
                          type: _type, 
                          date: _selectedDate, 
                          location: _location,
                          attendance: widget.eventSelected!.attendance,
                          duration: _duration,
                          moreInformation: _moreInfo,
                          repertoire: widget.eventSelected!.repertoire 
                        );
                        await ref.watch(eventProvider.notifier).updateEvent(widget.eventSelected!.id, updatedEvent);
                        Navigator.of(context).pop();
                      } else {
                        // Save new event
                        Event event = Event.create(
                          type: _type, 
                          date: _selectedDate, 
                          location: _location,
                          duration: _duration,
                          moreInformation: _moreInfo
                        );
                        await ref.watch(eventProvider.notifier).saveEvent(event);
                        await ref.watch(eventsProvider.notifier).updateEventsList(event);
                      }
                      Navigator.of(context).pop();
                    }                  
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