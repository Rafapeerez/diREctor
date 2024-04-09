import 'package:director_app_tfg/presentation/views/waiting_view.dart';
import 'package:flutter/material.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  static const String name = "waiting-screen";

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[Container()], //Hide default drawer icon
        elevation: 9,
        backgroundColor: colors.primary, 
        titleSpacing: 5,
        title: const Row(
          children: [
            SizedBox(width: 20),
            Flexible(
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
            SizedBox(width: 20), 
          ]
        ),
      ),
      body: const WaitingView()
    );
  }
}
