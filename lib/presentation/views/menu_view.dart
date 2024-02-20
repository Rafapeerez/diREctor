import 'package:director_app_tfg/presentation/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

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
          const CustomListTile(
            option: "Inicio",
            icon: Icon(Icons.home, size: 30),
            route: '/home-screen'
          ),
          const CustomListTile(
            option: "Historia",
            icon: Icon(Icons.history_edu_outlined, size: 30),
            route: '/history-screen'
          ),
          const CustomListTile(
            option: "Modo Nocturno",
            icon: Icon(Icons.brightness_medium_outlined, size: 30),
            hasSwitch: true,
          ),
          const CustomListTile(
            option: "Reglas",
            icon: Icon(Icons.file_copy_outlined, size: 30)
          ),
          const CustomListTile(
            option: "Cerrar Sesión",
            icon: Icon(Icons.logout_outlined, size: 30)
          ),
        ],
      ),
    );
  }
}
