import 'package:director_app_tfg/presentation/widgets/custom_card.dart';
import 'package:flutter/material.dart';

class EventsView extends StatelessWidget {
  const EventsView({super.key});

  @override
  Widget build(BuildContext context) {
    
    return const  SingleChildScrollView(
        child: Column(
          children: [
            CustomCard(title: 'Concierto', isAttendingEvent:true, description: 'Av. Almogávares (junto al hotel)', route: '/home/0/eventsdetails-screen'),
            CustomCard(title: 'Salida Procesional', isAttendingEvent:true, description: 'Av. Carlos III (junto a la heladeria)', route: '/home-screen/events-screen/eventsdetails-screen'),
          ],
        ),
    );
  }
}