import 'package:director_app_tfg/presentation/widgets/components/custom_bottom_navigationbar.dart';
import 'package:director_app_tfg/presentation/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:director_app_tfg/presentation/views/events_details_view.dart';

class EventsDetailsScreen extends StatelessWidget {
  static const String name = 'eventsdetails-screen';

  const EventsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      hasArrowBack: true,
      body: EventsDetailsView(), 
      bottomNavigationBar: CustomBottomNavigationBar( currentIndex: 0 )
    );
  }
}
