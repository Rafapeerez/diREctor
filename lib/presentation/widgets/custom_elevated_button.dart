import 'package:director_app_tfg/config/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const CustomElevatedButton({
    super.key,
    required this.icon,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.02,
      right: MediaQuery.of(context).size.width * 0.02,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: BUTTONS_COLOR,
          minimumSize: const Size(55, 55),
          shape: const CircleBorder(), 
          elevation: 5.0, 
          shadowColor: Colors.grey.withOpacity(0.5), 
        ),
        child: Icon(
          icon,
          color: Colors.black87,
          size: 30,
        ),
      )
    );
  }
}