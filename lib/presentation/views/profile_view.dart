import 'package:director_app_tfg/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final userState = ref.watch(userProvider);
    
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
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        'Perfil',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (userState.user != null && userState.user?.photoURL != null)
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(userState.user!.photoURL!),
                    ),
                ],
              ),
            ),
          ),
          _TextField(title: 'Nombre Completo', value: userState.user!.displayName),
          _TextField(title: 'Email', value: userState.user!.email),
          _TextField(title: 'Instrumento', value: userState.instrument),
          _TextField(title: 'Teléfono', value: userState.user!.phoneNumber),
        ],
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  
  final String title;
  final String? value;

  const _TextField({
    required this.title, 
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Text(
            "$title:", 
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            )
          ),
          const SizedBox(height: 5),
          Text(
            value ?? "-", 
            style: const TextStyle(
              fontSize: 14,
            )
          ),
          const SizedBox(height: 15)
        ],
      ),
    );
  }
}
