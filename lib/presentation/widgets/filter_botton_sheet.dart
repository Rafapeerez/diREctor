
import 'package:director_app_tfg/presentation/providers/march/march_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterBottomSheet extends ConsumerStatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  FilterBottomSheetState createState() => FilterBottomSheetState();
}

class FilterBottomSheetState extends ConsumerState<FilterBottomSheet> {
  List<String> filterOptions = ['Orden Asc Número', 'Orden Alfabético'];
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = filterOptions.first;
  }

  void _toggleOption(String option) {
    setState(() {
      selectedOption = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    final marchsProv = ref.read(marchsProvider.notifier);
    
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
                  return RadioListTile<String>(
                    title: Text(option),
                    value: option,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      _toggleOption(value!);
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
                      onPressed: ()  async {
                        if (selectedOption == "Orden Asc Número"){
                          await marchsProv.getAllMarchsOrderByNumber();
                          Navigator.pop(context);
                        }
                      },
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