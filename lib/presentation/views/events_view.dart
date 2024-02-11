import 'package:director_app_tfg/presentation/widgets/custom_appbar.dart';
import 'package:director_app_tfg/presentation/widgets/custom_card.dart';
import 'package:director_app_tfg/presentation/widgets/custom_menu_drawer.dart';
import 'package:flutter/material.dart';

class EventsView extends StatelessWidget {
  const EventsView({super.key});

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
            CustomCard(title: 'Concierto', isAttendingEvent:true, description: 'Av. Almogávares (junto al hotel)', route: 'events-screen'),
            CustomCard(title: 'Salida Procesional', isAttendingEvent:true, description: 'Av. Carlos III (junto a la heladeria)', route: 'events-screen'),
          ],
        ),
      ),
    );
  }
}