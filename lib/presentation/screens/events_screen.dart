import 'package:flutter/material.dart';
import 'package:director_app_tfg/presentation/views/events_view.dart';

class EventsScreen extends StatelessWidget {
  static const String name = 'events-screen';

  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const EventsView();
  }
}
