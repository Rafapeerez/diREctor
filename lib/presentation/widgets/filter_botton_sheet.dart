
import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  @override
  FilterBottomSheetState createState() => FilterBottomSheetState();
}

class FilterBottomSheetState extends State<FilterBottomSheet> {
  List<String> filterOptions = ['Orden Asc Número', 'Orden Alfabético'];
  Map<String, bool> selectedOptions = {};

  @override
  void initState() {
    super.initState();
    selectedOptions = filterOptions.asMap().map((key, value) => MapEntry(value, false));
  }

  void _toggleOption(String option, bool? value) {
    setState(() {
      selectedOptions[option] = value ?? false;
      for (String otherOption in filterOptions) {
        if (otherOption != option) {
          selectedOptions[otherOption] = !value!;
        }
      }
    });
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
                      _toggleOption(option, value);
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
                      child: const Text("Cancelar"),
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