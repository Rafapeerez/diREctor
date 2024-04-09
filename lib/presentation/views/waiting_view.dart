import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class WaitingView extends StatefulWidget {
  const WaitingView({
    super.key,
  });

  @override
  State<WaitingView> createState() => _WaitingViewState();
}

class _WaitingViewState extends State<WaitingView> {

  final List<String> _quotes = [
    "Ponte en contacto con el director...",
    "Cargando...",
    "Preparando la información...",
    "Procesando...",
  ];
  String _currentQuote = "";
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _updateQuote();
    _timer = Timer.periodic( const Duration(seconds: 5), (timer) {
      _updateQuote();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateQuote() {
    setState(() {
      _currentQuote = _quotes[Random().nextInt(_quotes.length)];
    });
  }

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
                "¡¡¡Bienvenido!!!",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 60),
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

              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Espere a que alguien de la junta directiva valide la cuenta y pueda acceder a la app...",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),

              const SizedBox(height: 120),
              const Center(
                child: CircularProgressIndicator.adaptive(
                  strokeWidth: 3,
                )
              ),
              const SizedBox(height: 16.0),
              Text(
                _currentQuote, 
                style: const TextStyle(
                  fontSize: 12
                )
              ),
            ],
          ),
        ]
      ),
    );
  }
}