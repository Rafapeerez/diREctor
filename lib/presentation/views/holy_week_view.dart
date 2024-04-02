import 'package:director_app_tfg/presentation/widgets/custom_card.dart';
import 'package:flutter/material.dart';

class HolyWeekView extends StatelessWidget {
  const HolyWeekView({super.key});

  @override
  Widget build(BuildContext context) {
    
    return ListView(
          children: const [
            CustomCard(title: 'Jueves de Pasión', image:'lib/config/assets/images/JuevesPasion.jpg', route: '/home/1/eventsdetails-screen'),
            CustomCard(title: 'Sábado de Pasión',   image:'lib/config/assets/images/SabadoPasion.jpg', route: '/home/1/eventsdetails-screen'),
            CustomCard(title: 'Domingo de Ramos', image:'lib/config/assets/images/DomingoRamos.jpg', route: '/home/1/eventsdetails-screen'),
            CustomCard(title: 'Lunes Santo', image: 'lib/config/assets/images/LunesSanto.jpeg', route: '/home/1/eventsdetails-screen'),
            CustomCard(title: 'Martes Santo', image:'lib/config/assets/images/Descanso.png', route: '/home/1/eventsdetails-screen'),
            CustomCard(title: 'Miércoles Santo', image:'lib/config/assets/images/MiercolesSanto.jpg', route: '/home/1/eventsdetails-screen'),
            CustomCard(title: 'Jueves Santo', image:'lib/config/assets/images/JuevesSanto.jpg', route: '/home/1/eventsdetails-screen'),
            CustomCard(title: 'Viernes Santo', image:'lib/config/assets/images/ViernesSanto.jpg', route: '/home/1/eventsdetails-screen'),
            CustomCard(title: 'Sábado Santo', image:'lib/config/assets/images/Descanso.png', route: '/home/1/eventsdetails-screen'),
            CustomCard(title: 'Domingo de Resurrección', image:'lib/config/assets/images/DomingoResurreccion.jpeg', route: '/home/1/eventsdetails-screen'),
            SizedBox(height: 10)
          ],
    );
  }
}
