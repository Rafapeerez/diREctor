import 'package:director_app_tfg/presentation/views/events_view.dart';
import 'package:director_app_tfg/presentation/views/holy_week_view.dart';
import 'package:director_app_tfg/presentation/views/marchs_view.dart';
import 'package:director_app_tfg/presentation/widgets/components/custom_bottom_navigationbar.dart';
import 'package:director_app_tfg/presentation/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'home-screen';
  final int pageIndex;

  const HomeScreen({
    super.key,
    required this.pageIndex
  });


  final viewRoutes = const <Widget>[
    EventsView(), // <----- 0
    HolyWeekView(),
    MarchsView()
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      hasArrowBack: false,
      body: IndexedStack( // <---- Save screens slides status
        index: pageIndex,
        children: viewRoutes
      ), 
      bottomNavigationBar: CustomBottomNavigationBar( currentIndex: pageIndex )
    );
  }
}
