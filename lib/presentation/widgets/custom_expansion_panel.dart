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
                      padding:  const EdgeInsets.fromLTRB(8, 4, 8, 2), 
                      child: Text(
                        widget.headerText,
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    );
                  }, 
                  body: Padding(
                    padding:  const EdgeInsets.fromLTRB(8, 4, 8, 8), 
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.expandedText
                        .split('-')
                        .where((line) => line.trim().isNotEmpty)
                        .map((line) => Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                line.trim(), 
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        )).toList(), 
                    ),
                  ),
                  isExpanded: _isExpanded,
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
