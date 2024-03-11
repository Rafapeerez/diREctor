import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigationBar({
    super.key, 
    required this.currentIndex
  });

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home/0');
      break;
      case 1:
        context.go('/home/1');
      break;
      case 2:
        context.go('/home/2');
      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 3, 
          ),
        ],
      ),
      child: BottomNavigationBar(
        elevation: 10,
        currentIndex: currentIndex,
        onTap: (value) => onItemTapped(context, value),
        fixedColor: colors.primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Eventos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star), 
            label: 'Semana Santa'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note_sharp), 
            label: 'Marchas'
          ),
        ],
      ),
    );
  }
}
