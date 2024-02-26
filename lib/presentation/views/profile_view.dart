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
                      Spacer(),
                      Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Icon(
                    Icons.account_circle_outlined,
                    size: 150,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
          const _TextField(title: 'Nombre', value: 'Rafael Emilio Perez Lopez'),
          const _TextField(title: 'Email', value: 'i02perl@uco.es'),
          const _TextField(title: 'Instrumento', value: 'Trompeta'),
          const _TextField(title: 'Teléfono', value: '-'),
          const _TextField(title: 'Cumpleaños', value: '30/08/2002'),
        ],
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  
  final String title;
  final String value;

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
            value, 
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
