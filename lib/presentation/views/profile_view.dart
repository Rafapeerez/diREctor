import 'package:director_app_tfg/presentation/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 300, // Ajusta el alto del DrawerHeader
            width: double.infinity,
            child: DrawerHeader(
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
              child: const Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Perfil',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height:20), 
                  Icon(
                    Icons.account_circle_outlined,
                    size: 150, 
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
