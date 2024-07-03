
import 'package:director_app_tfg/config/helpers/capitalize_string_helper.dart';
import 'package:director_app_tfg/domain/models/march.dart';
import 'package:director_app_tfg/presentation/providers/march/march_provider.dart';
import 'package:director_app_tfg/presentation/widgets/components/custom_submit_and_cancel_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MarchsForm extends ConsumerStatefulWidget {

  final March? marchSelected;

  const MarchsForm({
    super.key,
    this.marchSelected
  });

  @override
  EventsFormState createState() => EventsFormState();
}

class EventsFormState extends ConsumerState<MarchsForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _author = "";
  int _number = 0;
  String _moreInfo = "";
  String _link = "";

  @override
  void initState(){
    super.initState();
    if (widget.marchSelected != null) {
      _name = widget.marchSelected!.name;
      _author = widget.marchSelected!.author;
      _number = widget.marchSelected!.number;
      _link = widget.marchSelected!.link ?? "";
      _moreInfo = widget.marchSelected!.moreInformation ?? "";
    } else {
      _name = "";
      _author = "";
      _number = 0;
      _moreInfo = "";
      _link = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final marchsProv = ref.read(marchProvider.notifier);

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            //FORM
            // NUMBER
            TextFormField(
              initialValue: _number.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Ingresa el número de la marcha',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor ingresa el número';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  if (value.isNotEmpty) {
                    _number = int.tryParse(value) ?? _number;
                  } else {
                    _number = 0;
                  }
                });
              }
            ),
            const SizedBox(height: 16),

            // NAME
            TextFormField(
              initialValue: _name,
              decoration: const InputDecoration(
                labelText: 'Ingresa el nombre de la marcha',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor ingresa el nombre';
                }
                return null;
              },
              onChanged: (value) => setState(() => _name = CapitalizeString().capitalizeString(value))
            ),
            const SizedBox(height: 16),

            // AUTHOR
            TextFormField(
              initialValue: _author,
              decoration: const InputDecoration(
                labelText: 'Ingresa el autor',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor ingresa el autor';
                }
                return null;
              },
              onChanged: (value) => setState(() => _author = CapitalizeString().capitalizeString(value))
            ),
            const SizedBox(height: 16),

            //LINK
            TextFormField(
              initialValue: _link,
              decoration:const InputDecoration(
                labelText: 'Añadir link (opcional)'
              ),
              onChanged: (value) => setState(() => _link = value),
            ),
            const SizedBox(height: 16),

            //MORE INFO
            TextFormField(
              initialValue: _moreInfo,
              decoration: const InputDecoration(labelText: 'Añadir nota (opcional)'),
              onChanged: (value) => setState(() => _moreInfo = value),
            ),
            const SizedBox(height: 16),


            SubmitAndCancelButtons(
              onCancelPressed: () => Navigator.of(context).pop(),
              onSubmitedPressed: () async {
                if (_formKey.currentState!.validate()) {
                  if ( widget.marchSelected != null ) {
                    March updatedMarch = March.update(
                      uuid: widget.marchSelected!.id, 
                      name: _name, 
                      author: _author, 
                      number: _number, 
                      link: _link, 
                      moreInformation: _moreInfo
                    );
                    await ref.watch(marchProvider.notifier).updateMarch(updatedMarch);
                    ref.read(marchsProvider.notifier).getAllMarchsOrderByName();
                    Navigator.of(context).pop();
                  } else {
                    March march = March.create(
                      name: _name,
                      author: _author,
                      number: _number,
                      link: _link,
                      moreInformation: _moreInfo
                    );
                    await marchsProv.saveMarch(march);
                    await ref.watch(marchsProvider.notifier).updateMarchsList(march);
                    ref.read(marchsProvider.notifier).getAllMarchsOrderByName();
                  }
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
