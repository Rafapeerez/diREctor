import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 9,
      title: const Row(
        children: [
          Icon(Icons.menu, size: 40),
          SizedBox(width: 20),
          Flexible(
            child: Text(
              'A.M. Nuestro Padre Jesús de la Redención', 
              overflow: TextOverflow.ellipsis,
              maxLines: 2, 
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20
              )
            ),
          ),
          SizedBox(width: 20),
          Icon(Icons.account_circle_outlined, size: 40,)
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
