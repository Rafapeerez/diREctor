import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomMenuDrawer extends StatelessWidget {
  const CustomMenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: colors.primary,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Text(
              'Menú',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          const _CustomListTile(option: "Inicio", icon: Icon(Icons.home,size: 30), route: '/home-screen'),
          const _CustomListTile(option: "Historia", icon: Icon(Icons.history_edu_outlined,size: 30), route: '/history-screen'),
          const _CustomListTile(option: "Modo Nocturno", icon: Icon(Icons.brightness_medium_outlined,size: 30)),
          const _CustomListTile(option: "Cerrar Sesión", icon: Icon(Icons.logout_outlined,size: 30)),
        ],
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String option;
  final Icon icon;
  final String route;

  const _CustomListTile({
    required this.option, 
    required this.icon,
    this.route = ""
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        title: Row(
          children: [
            icon,
            const SizedBox(width: 20),
            Text(option)
          ]
        ),
        onTap: route == "" ? () {
          
        } : () {
          context.pop();
          context.go(route);
        },
      ),
      const Divider()
    ]);
  }
}
