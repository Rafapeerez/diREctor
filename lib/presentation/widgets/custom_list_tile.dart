import 'package:director_app_tfg/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CustomListTile extends StatefulWidget {
  final String option;
  final Icon icon;
  final String route;
  final bool hasSwitch;

  const CustomListTile({
    super.key,
    required this.option,
    required this.icon,
    this.route = "",
    this.hasSwitch = false
  });

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context);
    final colors = Theme.of(context).colorScheme;

    return Column(children: [
      ListTile(
        title: Row(children: [
          widget.icon,
          const SizedBox(width: 20),
          Text(widget.option),
          const Spacer(),
          widget.hasSwitch == true ? Switch(
              value: isDark,
              activeColor: colors.primary,
              onChanged: (bool value) {
                setState(() {
                  isDark = value;
                });
                theme.setTheme(value);
              },
            )
            : const SizedBox()
        ]),
        onTap: widget.route == ""
            ? () {}
            : () {
                context.pop();
                context.go(widget.route);
              },
      ),
      const Divider()
    ]);
  }
}
