import 'dart:async';

import 'package:director_app_tfg/presentation/widgets/custom_expansion_panel.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';


class EventsDetailsView extends StatefulWidget {
  const EventsDetailsView({super.key});

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 15,
  );

  @override
  State<EventsDetailsView> createState() => _EventsDetailsViewState();
}

class _EventsDetailsViewState extends State<EventsDetailsView> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    
    return  SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
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
            SizedBox(
              height: 200,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: EventsDetailsView._kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
            const Padding(
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
            const SizedBox(height: 5),
            const CustomExpansionPanel(
              headerText: "Día y Hora", 
              expandedText: "Día 8 de Marzo a las 18:00",
            ),
            const CustomExpansionPanel(
              headerText: "Repertorio", 
              expandedText: "- Marcha Real - Orando al Padre"
            ),
            const CustomExpansionPanel(
              headerText: "Notas", 
              expandedText: ""
            ),
            const SizedBox(height: 20)
          ],
        ),
    );
  }
}