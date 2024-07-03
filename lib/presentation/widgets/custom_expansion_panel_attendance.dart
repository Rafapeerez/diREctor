import 'package:director_app_tfg/presentation/providers/event/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomExpansionPanelAttendance extends ConsumerStatefulWidget {
  final String headerText;
  final bool isExpanded;

  const CustomExpansionPanelAttendance({
    super.key,
    required this.headerText,
    this.isExpanded = false,
  });

  @override
  ConsumerState<CustomExpansionPanelAttendance> createState() => CustomExpansionPanelAttendanceState();
}

class CustomExpansionPanelAttendanceState extends ConsumerState<CustomExpansionPanelAttendance> {
  late bool _isExpanded;
  List<String> attendance = [];

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded;
    attendance = ref.read(selectedEventProvider.notifier).state.attendance;
  }
  
  void toggleExapanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => toggleExapanded(),
      child: Column(
        children: [
          ExpansionPanelList(
            expandedHeaderPadding: EdgeInsets.zero,
            expansionCallback: (panelIndex, isExpanded) {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            children: [
              ExpansionPanel(
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
                      const SizedBox(height: 10),                    
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: attendance.length,
                        itemBuilder: (context, index) {
                          final musician = attendance[index];
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    musician,
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
                isExpanded: _isExpanded,
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
