import 'package:flutter/material.dart';

class WaitingView extends StatelessWidget {
  const WaitingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "¡¡¡Bienvenido!!!",
              style: TextStyle(fontSize: 25),
            ),
            // Expanded(
            //   child: Align(
            //     alignment: Alignment.center,
            //     child: Padding(
            //       padding: EdgeInsets.all(20.0),
            //       child: Text(
            //         "¡¡¡Bienvenido a la aplicación ofical de la A.M. Nuestro Padre Jesús de la Redención!!! \n\n Espere a que alguien de la junta directiva valide la cuenta y pueda acceder a la app...",
            //         style: TextStyle(fontSize: 20),
            //       ),
            //     ),
            //   ),
            // ),
            
          ],
        ),
      ),
    );
  }
}
