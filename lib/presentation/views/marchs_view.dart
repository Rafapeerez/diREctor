import 'package:director_app_tfg/config/helpers/capitalize_string_helper.dart';
import 'package:director_app_tfg/config/helpers/get_first_letter_from_each_word_of_string_helper.dart';
import 'package:director_app_tfg/domain/models/march.dart';
import 'package:director_app_tfg/presentation/providers/march/march_provider.dart';
import 'package:director_app_tfg/presentation/providers/user_provider.dart';
import 'package:director_app_tfg/presentation/widgets/circle_letter.dart';
import 'package:director_app_tfg/presentation/widgets/custom_elevated_button.dart';
import 'package:director_app_tfg/presentation/widgets/filter_botton_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MarchsView extends ConsumerStatefulWidget {
  const MarchsView({super.key});

  @override
  MarchsViewState createState() => MarchsViewState();
}

class MarchsViewState extends ConsumerState<MarchsView> {
  @override
  void initState() {
    super.initState();
    if (ref.read(marchsProvider.notifier).state == null) {
      ref.read(marchsProvider.notifier).getAllMarchs();
    } else {
      ref.read(marchsProvider.notifier).state;
    }
  }

  void showDialogMethod() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Marcha'),
          content: MarchsForm(),
        );
      }
    );
  }

  void showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return const FilterBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    final marchs = ref.watch(marchsProvider);

    return marchs.isNotEmpty
        ? Stack(children: [
            ListView.builder(
              itemCount: marchs.length,
              itemBuilder: (context, index) {
                final march = marchs[index];
                return Column(
                  children: [
                    _CustomMarch(
                        name: march.name,
                        letter: GetFirstLetterFromEachWordOfString
                            .getFirstLetterFromEachWordOfString(march.name)),
                  ],
                );
              },
            ),
            if (userState.isAdmin)
              CustomElevatedButton(
                icon: Icons.more_vert,
                onPressed: () {
                  final RenderBox button =
                      context.findRenderObject() as RenderBox;
                  final Offset buttonPosition =
                      button.localToGlobal(Offset.zero);

                  final double screenHeight =
                      MediaQuery.of(context).size.height;
                  final double screenWidth = MediaQuery.of(context).size.width;

                  final double dx = screenWidth - buttonPosition.dx;
                  final double dy = screenHeight - buttonPosition.dy - 150;

                  showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(dx, dy, 20, 0),
                    items: const [
                      PopupMenuItem(
                        value: 'Añadir',
                        child: Text('Añadir'),
                      ),
                      PopupMenuItem(
                        value: 'Filtrar',
                        child: Text('Filtrar'),
                      ),
                    ],
                    elevation: 8.0,
                  ).then((choice) {
                    if (choice != null) {
                      if (choice == 'Añadir') {
                        showDialogMethod();
                      } else if (choice == 'Filtrar') {
                        showFilterBottomSheet();
                      }
                    }
                  });
                },
              )
            else
              CustomElevatedButton(
                icon: Icons.filter_alt_rounded,
                onPressed: () {
                  showFilterBottomSheet();
                },
              )
          ])
        : Stack(children: [
            const Center(
              child: Text(
                "No hay marchas",
                style: TextStyle(color: Colors.grey, fontSize: 22),
              ),
            ),
            if (userState.isAdmin)
              CustomElevatedButton(
                icon: Icons.add,
                onPressed: () async {
                  showDialogMethod();
                },
              )
          ]);
  }
}

class _CustomMarch extends StatelessWidget {
  final String name;
  final String letter;

  const _CustomMarch({required this.name, required this.letter});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go("/home/2/marchdetails-screen");
      },
      child: Column(
        children: [
          ListTile(
            title: Row(
              children: [
                CircleLetter(letter: letter),
                const SizedBox(width: 20),
                Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 20),
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_outlined,
                  size: 30,
                )
              ],
            ),
          ),
          const Divider()
        ],
      ),
    );
  }
}

class MarchsForm extends ConsumerStatefulWidget {
  const MarchsForm({super.key});

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
                }),
            const SizedBox(height: 16),

            // NAME
            TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Ingresa el nombre de la marcha',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa el nombre';
                  }
                  return null;
                },
                onChanged: (value) => setState(
                    () => _name = CapitalizeString().capitalizeString(value))),
            const SizedBox(height: 16),

            // AUTHOR
            TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Ingresa el autor',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa el autor';
                  }
                  return null; // Retorna null si el valor es válido
                },
                onChanged: (value) => setState(() =>
                    _author = CapitalizeString().capitalizeString(value))),
            const SizedBox(height: 16),

            //LINK
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'Añadir link (opcional)'),
              onChanged: (value) => setState(() => _link = value),
            ),
            const SizedBox(height: 16),

            //MORE INFO
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'Añadir nota (opcional)'),
              onChanged: (value) => setState(() => _moreInfo = value),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //CANCEL BUTTON
                OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Cancelar")),
                const Spacer(flex: 1),

                //SUBMIT BUTTON
                FilledButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      March march = March.create(
                          name: _name,
                          author: _author,
                          number: _number,
                          link: _link,
                          moreInformation: _moreInfo);
                      await marchsProv.saveMarch(march);
                      await ref
                          .watch(marchsProvider.notifier)
                          .updateMarchsList(march);
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
