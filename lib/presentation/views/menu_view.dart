import 'package:director_app_tfg/infrastructure/services/google_services.dart';
import 'package:director_app_tfg/presentation/providers/user_provider.dart';
import 'package:director_app_tfg/presentation/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MenuView extends ConsumerWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final userState = ref.watch(userProvider);

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
          CustomListTile(
            option: "Historia",
            icon: const Icon(Icons.history_edu_outlined, size: 30),
            onTap: (){},
          ),
          CustomListTile(
            option: "Modo Nocturno",
            icon: const Icon(Icons.brightness_medium_outlined, size: 30),
            hasSwitch: true,
            onTap: (){},
          ),
          CustomListTile(
            option: "Reglas",
            icon: const Icon(Icons.file_copy_outlined, size: 30),
            onTap: () {
              context.go("/home/0/pdfviewer-screen");
            },
          ),
          if (userState.isAdmin)
            CustomListTile(
              option: "Peticiones de entrada",
              icon: const Icon(Icons.add_circle_outline_rounded, size: 30),
              onTap: () {
                context.go("/home/0/userlist-screen");
              }
            ),  
          CustomListTile(
            option: "Cerrar Sesión",
            icon: const Icon(Icons.logout_outlined, size: 30),
            onTap: () async {
              await GoogleServices.signOut();
              context.go("/");
            }
          ),
        ],
      ),
    );
  }
}