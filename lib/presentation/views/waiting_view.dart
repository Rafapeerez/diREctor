import 'package:flutter/material.dart';

class WaitingView extends StatelessWidget {
  const WaitingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
            Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Text(
                "¡¡¡Bienvenido!!!",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 60),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Esta es la aplicación oficial de la A.M. Nuestro Padre Jesús de la Redención de Córdoba.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),

              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Cuando la junta directiva valide la cuenta podrá acceder al contenido de la aplicación. Rogamos paciencia.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ]
      ),
    );
  }
}