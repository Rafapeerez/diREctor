import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  
  final GlobalKey<ScaffoldState> scaffoldKey;

  const CustomAppBar({
    super.key, 
    required this.scaffoldKey
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return AppBar(
      automaticallyImplyLeading: false,
      actions: <Widget>[Container()], //Hide default drawer icon
      elevation: 9,
      backgroundColor: colors.primary, 
      titleSpacing: 5,
      title: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu, size: 40, color: Colors.white),
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            }
          ),
          const SizedBox(width: 20),
          const Flexible(
            child: Text(
              'A.M. Nuestro Padre Jesús de la Redención', 
              overflow: TextOverflow.ellipsis,
              maxLines: 2, 
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              )
            ),
          ),
          const SizedBox(width: 20),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined, size: 40, color: Colors.white),
            onPressed: () {
              scaffoldKey.currentState!.openEndDrawer(); // Abre el endDrawer
            }
          ),
        ],
      ),
    );
  }
}
