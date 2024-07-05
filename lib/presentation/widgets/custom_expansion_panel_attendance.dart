import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/presentation/providers/event/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomExpansionPanelAttendance extends ConsumerStatefulWidget {
  final String headerText;
  final bool isExpanded;
  final ScrollController? scrollController;
  final Event event;

  const CustomExpansionPanelAttendance({
    super.key,
    required this.headerText,
    this.isExpanded = false,
    this.scrollController,
    required this.event
  });

  @override
  ConsumerState<CustomExpansionPanelAttendance> createState() => CustomExpansionPanelAttendanceState();
}

class CustomExpansionPanelAttendanceState extends ConsumerState<CustomExpansionPanelAttendance> {
  late bool _isExpanded;
  late List<String> filteredAttendance;
  final TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded;
    
    filteredAttendance = [];

    searchController.addListener(() {
      filterSearchResults(searchController.text);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      filterSearchResults('');
    });
  }

  void filterSearchResults(String query) {
    final attendance = ref.read(selectedEventProvider).attendance;
    if (query.isEmpty) {
      setState(() {
        filteredAttendance = List.from(attendance);
      });
    } else {
      setState(() {
        filteredAttendance = attendance.where((item) => item.toLowerCase().contains(query.toLowerCase())).toList();
      });
    }
  }

  void toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      _scroll(300);
    });
  }

  void _scroll(int offset) {
    if (_isExpanded && widget.scrollController != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.scrollController!.animateTo(
          widget.scrollController!.position.maxScrollExtent + offset,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => toggleExpanded(),
      child: Column(
        children: [
          ExpansionPanelList(
            expandedHeaderPadding: EdgeInsets.zero,
            expansionCallback: (panelIndex, isExpanded) {
              toggleExpanded();
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
                      TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          labelText: "Buscar",
                          hintText: "Buscar",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 300,
                        child: Scrollbar(
                          controller: _scrollController,
                          thumbVisibility: true,
                          trackVisibility: false,
                          thickness: 6,
                          radius: const Radius.circular(10),
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount: filteredAttendance.length,
                            itemBuilder: (context, index) {
                              final musician = filteredAttendance[index];
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          musician,
                                          style: const TextStyle(fontSize: 20),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () async {
                                          ref.read(selectedEventProvider.notifier).removeAttendee(musician);
                                          await ref.read(attendanceProvider.notifier).deleteMusicianFromEvent(widget.event.id, musician);
                                          filterSearchResults(searchController.text);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
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