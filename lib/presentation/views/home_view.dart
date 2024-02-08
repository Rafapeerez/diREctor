import 'package:director_app_tfg/presentation/widgets/custom_appbar.dart';
import 'package:director_app_tfg/presentation/widgets/custom_card.dart';
import 'package:director_app_tfg/presentation/widgets/custom_menu_drawer.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
      drawer: const CustomMenuDrawer(),
      body: const Column(
        children: [
          CustomCard(title: 'Concierto', isAttendingEvent: true,/*  image:'lib/config/assets/images/PalmSunday.jpg',*/description: 'asdasdadasdasssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss', )
        ],
      ),
    );
  }
}