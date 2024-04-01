import 'dart:async';

import 'package:director_app_tfg/config/helpers/geolocalitation_from_direction_helper.dart';
import 'package:director_app_tfg/presentation/widgets/custom_expansion_panel.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventsDetailsView extends StatefulWidget {
  const EventsDetailsView({super.key});

  @override
  State<EventsDetailsView> createState() => _EventsDetailsViewState();
}

class _EventsDetailsViewState extends State<EventsDetailsView> {
  static const CameraPosition _position = CameraPosition(
    target: LatLng(37.879773062359, -4.778913767228612),
    zoom: 14,
  );
  
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  Set<Marker> _markers = {};
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();
    _addMarkerFromAddress();
  }

  Future<void> _addMarkerFromAddress() async {
    try {
      LatLng coordinates = await GeolocalitationFromDirection().getLatLngFromAddress("Puente Romano de Cordoba");

      Marker marker = Marker(
        markerId: const MarkerId('marker_1'),
        position: coordinates,
      );

      setState(() {
        _markers = {marker};
        _errorMessage="";
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Error: No se encontraron coordenadas para la dirección proporcionada";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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

          //MAP
          if(_errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          SizedBox(
            height: 200,
            child:GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _position,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: _markers,
            )
          ),


          //DIRECTION
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
