import 'package:director_app_tfg/presentation/widgets/custom_expansion_panel.dart';
import 'package:flutter/material.dart';

class EventsDetailsView extends StatelessWidget {
  const EventsDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    
    return const SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Concierto", 
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
            Placeholder(),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      "Dirección: Av. Almogávares (junto al hotel)",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            CustomExpansionPanel(
              headerText: "Día y Hora", 
              expandedText: "Día 8 de Marzo a las 18:00",
            ),
            CustomExpansionPanel(
              headerText: "Repertorio", 
              expandedText: "- Marcha Real - Orando al Padre"
            ),
            CustomExpansionPanel(
              headerText: "Notas", 
              expandedText: ""
            ),
            SizedBox(height: 20)
          ],
        ),
    );
  }
}