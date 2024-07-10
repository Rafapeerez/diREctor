import 'package:director_app_tfg/presentation/providers/musician/musician_provider.dart';
import 'package:director_app_tfg/presentation/providers/theme_provider.dart';
import 'package:director_app_tfg/presentation/providers/user_provider.dart';
import 'package:director_app_tfg/presentation/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MenuView extends ConsumerStatefulWidget {
  const MenuView({super.key});

  @override
  MenuViewState createState() => MenuViewState();
}

class MenuViewState extends ConsumerState<MenuView> {

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final userState = ref.watch(userProvider);
    ref.read(countNotAllowedMusiciansProvider.notifier).countNotAllowedMusicians();
    final count = ref.watch(countNotAllowedMusiciansProvider);

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
            child: Column(children: [
              const Text('Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                )
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 70,
                child: Image.asset('lib/config/assets/images/diREctor_ligth.png'),
              )
            ]),
          ),
          CustomListTile(
            option: "Modo Nocturno",
            icon: const Icon(Icons.brightness_medium_outlined, size: 30),
            hasSwitch: true,
            onTap: () {
              ref.read(themeNotifierProvider.notifier).toggleDarkMode();
            },
          ),
          CustomListTile(
            option: "Reglas",
            icon: const Icon(Icons.file_copy_outlined, size: 30),
            onTap: () {
              context.go("/home/0/pdfviewer-screen");
            },
          ),
          CustomListTile(
            option: "Logros",
            icon: const Icon(Icons.timeline_outlined, size: 30),
            onTap: () {
              context.go("/home/0/achievement-screen");
            },
          ),
          if (userState.isAdmin)
            CustomListTile(
              option: "Solicitudes",
              icon: const Icon(Icons.add_circle_outline_rounded, size: 30),
              count: count,
              onTap: () {
                context.go("/home/0/userlist-screen");
              }
            ),
        ],
      ),
    );
  }
}
