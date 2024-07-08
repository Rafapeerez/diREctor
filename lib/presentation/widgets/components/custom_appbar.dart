import 'package:director_app_tfg/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool hasArrowBack;

  const CustomAppBar({
    super.key, 
    required this.scaffoldKey, 
    required this.hasArrowBack
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final userState = ref.watch(userProvider);

    return AppBar(
      automaticallyImplyLeading: false,
      actions: <Widget>[Container()], // Hide default drawer icon
      elevation: 9,
      backgroundColor: colors.primary, 
      titleSpacing: 5,
      title: LayoutBuilder(
        builder: (context, constraints) {
          bool isPortrait = constraints.maxWidth < 600;

          return Row(
            mainAxisAlignment: isPortrait ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
            children: [
              if (hasArrowBack) 
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back, 
                    size: 40, 
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }
                )
              else 
                IconButton(
                  icon: const Icon(
                    Icons.menu, 
                    size: 40, 
                    color: Colors.white,
                  ),
                  onPressed: () {
                    scaffoldKey.currentState!.openDrawer();
                  }
                ),
              if (isPortrait) 
                const SizedBox(width: 20),
              if (isPortrait)
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
              if (!isPortrait) 
                const Expanded(
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
              if (isPortrait) 
                const SizedBox(width: 20),
              IconButton(
                icon: CircleAvatar(
                  backgroundImage: NetworkImage(userState.user!.photoURL!),
                  radius: 20,
                ),
                onPressed: () {
                  scaffoldKey.currentState!.openEndDrawer(); 
                }
              ),
            ],
          );
        }
      ),
    );
  }
}
