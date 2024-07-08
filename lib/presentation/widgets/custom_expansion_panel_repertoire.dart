import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/domain/models/march.dart';
import 'package:director_app_tfg/presentation/providers/event/event_provider.dart';
import 'package:director_app_tfg/presentation/providers/march/march_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomExpansionPanelRepertoire extends ConsumerStatefulWidget {
  final String headerText;
  final bool isExpanded;
  final ScrollController? scrollController;

  const CustomExpansionPanelRepertoire({
    super.key,
    required this.headerText,
    this.isExpanded = false,
    this.scrollController
  });

  @override
  ConsumerState<CustomExpansionPanelRepertoire> createState() => CustomExpansionPanelRepertoireState();
}

class CustomExpansionPanelRepertoireState extends ConsumerState<CustomExpansionPanelRepertoire> {
  late bool _isExpanded;
  List<String> selectedMarches = [];
  String _marchName = "";
  List<String> repertoire = [];
  late TextEditingController _marchController;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded;
    repertoire = ref.read(selectedEventProvider).repertoire;
    _marchController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    repertoire = ref.read(selectedEventProvider).repertoire;
  }
  
  void toggleExapanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      _scroll(20);
    });
  }

  void _scroll(int offset) {
    if (_isExpanded && widget.scrollController != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.scrollController!.animateTo(
          widget.scrollController!.position.pixels + offset,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final eventProv = ref.watch(eventProvider.notifier);

    return GestureDetector(
      onTap: () => toggleExapanded(),
      child: Column(
        children: [
          ExpansionPanelList(
            expandedHeaderPadding: EdgeInsets.zero,
            expansionCallback: (panelIndex, isExpanded) {
              toggleExapanded();
            },
            children: [
              ExpansionPanel(
                isExpanded: _isExpanded,
                headerBuilder: (context, isExpanded) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 2),
                    child: Row(
                      children: [
                        Text(
                          widget.headerText,
                          style: const TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Autocomplete<March>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          final marchs = ref.read(marchsProvider);
                          final filteredMarches = marchs.where((march) => !repertoire.contains(march.name.toLowerCase()) && !selectedMarches.contains(march.name.toLowerCase()) && march.name.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                          return filteredMarches;
                        },
                        displayStringForOption: (March march) => march.name,
                        onSelected: (option) {
                          _marchName = option.name;
                        },
                        fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                          _marchController = textEditingController;
                          return TextField(
                            controller: textEditingController,
                            focusNode: focusNode,
                            decoration: const InputDecoration(
                              labelText: "Buscar",
                              hintText: "Buscar",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                              ),
                            ),
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FilledButton(
                            onPressed: () {
                              if (_marchName != "") {
                                setState(() {
                                  selectedMarches.add(_marchName);
                                  _marchController.clear();
                                });
                              }
                              FocusScope.of(context).unfocus();
                            },
                            child: const Text("Apuntar")
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: selectedMarches.length,
                        itemBuilder: (context, index) {
                          final march = selectedMarches[index];
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    march,
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      setState(() {
                                        selectedMarches.removeAt(index);
                                      });
                                    },
                                  )
                                ],
                              )
                            ]
                          );
                        },
                      ),
                      selectedMarches.isNotEmpty
                        ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FilledButton(
                              onPressed: () async {
                                Event updatedEvent = await eventProv.updateRepertoire(selectedMarches, ref.watch(selectedEventProvider));
                                ref.read(selectedEventProvider.notifier).updateEvent(updatedEvent);
                                setState(() {
                                  repertoire = updatedEvent.repertoire;
                                });
                                setState(() {
                                  selectedMarches.clear();
                                });
                                _marchController.clear();
                                FocusScope.of(context).unfocus();
                              },
                              child: const Text("Guardar"),
                            ),
                          ],
                        )
                        : const SizedBox(),
                      const SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: repertoire.length,
                        itemBuilder: (context, index) {
                          final march = repertoire[index];
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    march,
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              )
                            ]
                          );
                        },
                      ),
                    ]
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
