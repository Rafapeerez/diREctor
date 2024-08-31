import 'package:flutter/material.dart';

class WaitingView extends StatelessWidget {
  const WaitingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                "¡¡¡Bienvenido/a!!!",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Esta es la aplicación oficial de la A.M. Nuestro Padre Jesús de la Redención de Córdoba.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),

              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Cuando la junta directiva valide la cuenta podrá acceder al contenido de la aplicación.  Esto se puede demorar un par de días, rogamos paciencia.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 70,
                child: Image.asset('lib/config/assets/images/diREctor.png'),
              ),

              SizedBox(
                height: 200,
                child: Image.asset('lib/config/assets/images/icon.png'),
              )
            ],
          ),
        ]
      ),
    );
  }
}