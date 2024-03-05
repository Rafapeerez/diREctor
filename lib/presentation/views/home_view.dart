import 'package:director_app_tfg/presentation/widgets/components/custom_scaffold.dart';
import 'package:director_app_tfg/presentation/widgets/custom_card.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    
    return const CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomCard(title: 'Eventos', image:'lib/config/assets/images/Eventos.jpg', description: 'Salidas Procesionales y Conciertos', route: '/home-screen/events-screen'),
            CustomCard(title: 'Semana Santa',   image:'lib/config/assets/images/SemanaSanta.jpg', description: 'Todos los días de nuestra Semana Santa', route: '/home-screen/holyweek-screen'),
            CustomCard(title: 'Repertorio', image: 'lib/config/assets/images/Repertorio.jpg', description: 'Marchas', route: '/home-screen/marchs-screen'),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}