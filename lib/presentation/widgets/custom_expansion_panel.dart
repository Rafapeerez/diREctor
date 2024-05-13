import 'package:flutter/material.dart';

class CustomExpansionPanel extends StatefulWidget {
  final String headerText;
  final String expandedText;
  final bool isExpanded;
  final bool isImportant;

  const CustomExpansionPanel({
    super.key,
    required this.headerText,
    required this.expandedText,
    this.isExpanded = false,
    this.isImportant = false
  });

  @override
  State<CustomExpansionPanel> createState() => _CustomExpansionPanelState();
}

class _CustomExpansionPanelState extends State<CustomExpansionPanel> {

  late bool _isExpanded;
  bool isImportant = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded;
    isImportant = widget.isImportant;
  }

  void toggleExapanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

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
                      padding: const EdgeInsets.fromLTRB(8, 4, 8, 2), 
                      child: Row(
                        children: [
                          Text(
                            widget.headerText,
                            style: const TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          const Spacer(),
                          isImportant
                          ? Icon(
                              Icons.circle_notifications,
                              color: colors.primary,
                            )
                          : const SizedBox()
                        ],
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
