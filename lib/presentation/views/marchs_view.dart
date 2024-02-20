import 'package:director_app_tfg/presentation/views/menu_view.dart';
import 'package:director_app_tfg/presentation/widgets/circle_letter.dart';
import 'package:director_app_tfg/presentation/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class MarchsView extends StatelessWidget {
  const MarchsView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(scaffoldKey: scaffoldKey),
      drawer: const MenuView(),
      body: ListView(
        children: const [
          _CustomMarch(name: "Marcha Real" , letter: "MR"),
          _CustomMarch(name: "Orando al Padre", letter: "OP",),
          _CustomMarch(name: "Caenaculum", letter: "C",),
        ],
      ),
    );
  }
}

class _CustomMarch extends StatelessWidget {
  final String name;
  final String letter;

  const _CustomMarch({
    required this.name,
    required this.letter
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
      },
      child: Column(
        children: [
          ListTile(
            title: Row(
              children: [
                CircleLetter(letter: letter),
                const SizedBox(width: 20),
                Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20
                  ),
                ),
                const Spacer(),
                const Icon( 
                  Icons.arrow_forward_outlined,
                  size: 30,
                )
              ],
            ),
          ),
          const Divider()
        ],
      ),
    );
  }
}
