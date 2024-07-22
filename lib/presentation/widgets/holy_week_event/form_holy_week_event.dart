import 'dart:typed_data';

import 'package:director_app_tfg/config/helpers/capitalize_string_helper.dart';
import 'package:director_app_tfg/domain/models/holy_week_event.dart';
import 'package:director_app_tfg/presentation/providers/holy_week_event/holy_week_event_provider.dart';
import 'package:director_app_tfg/presentation/widgets/components/custom_submit_and_cancel_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class HolyWeekEventsForm extends ConsumerStatefulWidget {

  final HolyWeekEvent? holyWeekEventSelected;

  const HolyWeekEventsForm({
    super.key,
    this.holyWeekEventSelected
  });

  @override
  HolyWeekEventsFormState createState() => HolyWeekEventsFormState();
}

class HolyWeekEventsFormState extends ConsumerState<HolyWeekEventsForm> {
  final _formKey = GlobalKey<FormState>();  
  DateTime _selectedDate = DateTime.now();
  Duration _duration = const Duration();
  String _location = "";
  String _moreInfo = "";
  Uint8List? _imageFile;
  String? imageUrl;

  List<String> options = ['Concierto', 'Salida Procesional'];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.holyWeekEventSelected != null) {
      _selectedDate = widget.holyWeekEventSelected!.date;
      _duration = widget.holyWeekEventSelected!.duration;
      _location = widget.holyWeekEventSelected!.location;
      _moreInfo = widget.holyWeekEventSelected!.moreInformation;
      imageUrl = widget.holyWeekEventSelected!.imageURL;
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

            //IMAGE
            _imageFile != null
                ? Image.memory(
                    _imageFile!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  )
                : widget.holyWeekEventSelected!.imageURL.isNotEmpty
                    ? Image.network(
                        widget.holyWeekEventSelected!.imageURL,
                        width: 200,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.image, size: 100),
            ElevatedButton(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  final imageFile = await image.readAsBytes();
                  setState(() {
                    _imageFile = imageFile;
                  });
                }
              },
              child: const Text("Elegir Imagen"),
            ),
            const SizedBox(height: 16),

            //DATE
            ListTile(
              title: const Text("Ingresa una fecha: "),
              subtitle: Text("${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year} a las ${_selectedDate.hour}:${_selectedDate.minute}"),
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
            
            SubmitAndCancelButtons(
              onCancelPressed: _isLoading ? null : () => Navigator.of(context).pop(),
              onSubmitedPressed: _isLoading ? null : () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _isLoading = true;
                  });

                  if (widget.holyWeekEventSelected != null) {
                    try {
                      final uploadImageUseCase = ref.read(uploadImageProvider);
                      final updateHolyWeekEventUseCase = ref.read(updateHolyWeekEventProvider);
                      
                      if (_imageFile != null) {
                        imageUrl = await uploadImageUseCase.execute(_imageFile!, widget.holyWeekEventSelected!.id);
                      }

                      HolyWeekEvent updatedEvent = HolyWeekEvent.update(
                          id: widget.holyWeekEventSelected!.id,
                          name: widget.holyWeekEventSelected!.name,
                          image: imageUrl!,
                          date: _selectedDate, 
                          location: _location,
                          duration: _duration,
                          moreInformation: _moreInfo
                        );
                        await updateHolyWeekEventUseCase.execute(updatedEvent);
              
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    } catch (e) {
                      // Manejar el error aquí
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error al actualizar el evento: $e')),
                      );
                    } finally {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  }
                }
              },
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }
}