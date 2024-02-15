import 'package:director_app_tfg/presentation/views/menu_view.dart';
import 'package:director_app_tfg/presentation/widgets/custom_appbar.dart';
import 'package:director_app_tfg/presentation/widgets/custom_card.dart';
import 'package:flutter/material.dart';

class HolyWeekView extends StatelessWidget {
  const HolyWeekView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(scaffoldKey: scaffoldKey),
      drawer: const MenuView(),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            CustomCard(title: 'Jueves de Pasión', image:'lib/config/assets/images/JuevesPasion.jpg', route: '/home-screen/events-screen'),
            CustomCard(title: 'Sábado de Pasión',   image:'lib/config/assets/images/SabadoPasion.jpg', route: '/home-screen/holyweek-screen'),
            CustomCard(title: 'Domingo de Ramos', image:'lib/config/assets/images/DomingoRamos.jpg', route: 'rules-screen'),
            CustomCard(title: 'Lunes Santo', image: 'lib/config/assets/images/LunesSanto.jpeg', route: 'march-screen'),
            CustomCard(title: 'Martes Santo', image:'lib/config/assets/images/Descanso.png', route: 'rules-screen'),
            CustomCard(title: 'Miércoles Santo', image:'lib/config/assets/images/MiercolesSanto.jpg', route: 'rules-screen'),
            CustomCard(title: 'Jueves Santo', image:'lib/config/assets/images/JuevesSanto.jpg', route: 'rules-screen'),
            CustomCard(title: 'Viernes Santo', image:'lib/config/assets/images/ViernesSanto.jpg', route: 'rules-screen'),
            CustomCard(title: 'Sábado Santo', image:'lib/config/assets/images/Descanso.png', route: 'rules-screen'),
            CustomCard(title: 'Domingo de Resurrección', image:'lib/config/assets/images/DomingoResurreccion.jpeg', route: 'rules-screen'),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
/*  */}
