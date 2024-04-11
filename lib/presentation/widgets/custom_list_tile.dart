import 'package:director_app_tfg/presentation/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomListTile extends ConsumerStatefulWidget {
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
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomListTileState();
}

class _CustomListTileState extends ConsumerState<CustomListTile> {

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(themeNotifierProvider).isDarkMode;
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        ListTile(
          title: Row(
            children: [
              widget.icon,
              const SizedBox(width: 20),
              Text(widget.option),
              const Spacer(),
              widget.hasSwitch == true 
                ? Switch(
                  value: isDarkMode,
                  activeColor: colors.primary,
                  onChanged: (value) => ref.read(themeNotifierProvider.notifier).toggleDarkMode(),
                )
                : const SizedBox()
            ]
          ),
          onTap: widget.route == "" && widget.hasSwitch == false
            ? () {
              
            }
            : () {
              context.pop();
              context.go(widget.route);
            },
        ),
      const Divider()
    ]);
  }
}
