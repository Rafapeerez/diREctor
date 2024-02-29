import 'package:flutter/material.dart';

class CustomExpansionPanel extends StatefulWidget {
  final String headerText;
  final String expandedText;

  const CustomExpansionPanel({
    super.key,
    required this.headerText,
    required this.expandedText,
  });

  @override
  State<CustomExpansionPanel> createState() => _CustomExpansionPanelState();
}

class _CustomExpansionPanelState extends State<CustomExpansionPanel> {

  bool _isExpanded = false;

  void toggleExapanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () => toggleExapanded(),
        child: ExpansionPanelList(
          expansionCallback: (panelIndex, isExpanded) {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          children: [
            ExpansionPanel(
              headerBuilder: (context, isExpanded) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    widget.headerText,
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                );
              }, 
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.expandedText,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              isExpanded: _isExpanded,
            ),
          ],
        ),
      ),
    );
  }
}
