import 'package:flutter/material.dart';

class CircleLetter extends StatelessWidget {
  
  final String letter;

  const CircleLetter({
    super.key,
    required this.letter
  });

  @override
  Widget build(BuildContext context) {
    
    final colors = Theme.of(context).colorScheme;
    
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.primary,
      ),
      child: Center(
        child: Text(
          letter,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 40 * 0.5, // Ajusta el tamaño de la letra según el tamaño del círculo
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
