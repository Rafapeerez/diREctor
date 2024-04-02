import 'package:director_app_tfg/presentation/widgets/circle_letter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MarchsView extends StatefulWidget {
  const MarchsView({super.key});

  @override
  State<MarchsView> createState() => _MarchsViewState();
}

class _MarchsViewState extends State<MarchsView> {
  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return _FilterBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: const [
            _CustomMarch(name: "Marcha Real", letter: "MR"),
            _CustomMarch(
              name: "Orando al Padre",
              letter: "OP",
            ),
            _CustomMarch(
              name: "Caenaculum",
              letter: "C",
            ),
          ],
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.02,
          right: MediaQuery.of(context).size.width * 0.05,
          child: FloatingActionButton(
            onPressed: () {
              _showFilterBottomSheet();
            },
            shape: const CircleBorder(),
            child: const Icon(Icons.filter_alt),
          )
        )
      ]
    );
  }
}

class _FilterBottomSheet extends StatefulWidget {
  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<_FilterBottomSheet> {
  List<String> filterOptions = ['Orden Asc Número', 'Orden Alfabético'];
  Map<String, bool> selectedOptions = {};

  @override
  void initState() {
    super.initState();
    selectedOptions = filterOptions.asMap().map((key, value) => MapEntry(value, false));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Wrap(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Filtros',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 16),
                ...filterOptions.map((option) {
                  return CheckboxListTile(
                    title: Text(option),
                    value: selectedOptions[option] ?? false,
                    onChanged: (bool? value) {
                      setState(() {
                        selectedOptions[option] = value ?? false;
                      });
                    },
                  );
                }).toList(),

                const SizedBox(height: 16),

                //Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context), 
                      child: const Text("Cancelar")
                    ),
                    const Spacer(flex: 1),
                    FilledButton(
                      onPressed: () {},
                      child: const Text("Aplicar"),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
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
