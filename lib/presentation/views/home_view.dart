import 'package:director_app_tfg/presentation/widgets/custom_appbar.dart';
import 'package:director_app_tfg/presentation/widgets/custom_card.dart';
import 'package:director_app_tfg/presentation/widgets/custom_menu_drawer.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(scaffoldKey: scaffoldKey),
      drawer: const CustomMenuDrawer(),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            CustomCard(title: 'Eventos', image:'lib/config/assets/images/eventos.jpg', description: 'Salidas Procesionales y Conciertos', route: '/home-screen/events-screen'),
            CustomCard(title: 'Semana Santa',   image:'lib/config/assets/images/SemanaSanta.jpg', description: 'Todos los días de nuestra Semana Santa', route: 'Easter-screen'),
            CustomCard(title: 'Repertorio', image: 'lib/config/assets/images/repertorio.jpg', description: 'Marchas', route: 'march-screen'),
            CustomCard(title: 'Reglas', image:'lib/config/assets/images/Reglas.jpg', route: 'rules-screen'),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}