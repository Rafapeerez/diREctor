import 'package:flutter/material.dart';
import 'package:director_app_tfg/presentation/views/events_details_view.dart';

class EventsDetailsScreen extends StatelessWidget {
  static const String name = 'eventsdetails-screen';

  const EventsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const EventsDetailsView();
  }
}
