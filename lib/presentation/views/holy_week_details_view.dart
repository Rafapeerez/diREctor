import 'dart:async';

import 'package:director_app_tfg/config/helpers/date_to_string_helper.dart';
import 'package:director_app_tfg/config/helpers/duration_to_string_helper.dart';
import 'package:director_app_tfg/config/helpers/geolocalitation_from_direction_helper.dart';
import 'package:director_app_tfg/domain/models/holy_week_event.dart';
import 'package:director_app_tfg/presentation/providers/event/holy_week_event_provider.dart';
import 'package:director_app_tfg/presentation/widgets/custom_expansion_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class HolyWeekDetailsView extends ConsumerStatefulWidget {
  const HolyWeekDetailsView({super.key});

  @override
  EventsDetailsViewState createState() => EventsDetailsViewState();
}

class EventsDetailsViewState extends ConsumerState<HolyWeekDetailsView> {
  
  CameraPosition? _position;
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  late final HolyWeekEvent? holyWeekEventSelected;

  Set<Marker> _markers = {};
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();  
    _initEventSelected(); 
  }

  void _initEventSelected() async {
    holyWeekEventSelected = ref.read(selectedHolyWeekEventProvider.notifier).state;
    LatLng targetLatLng = await GeolocalitationFromDirection().getLatLngFromAddress(holyWeekEventSelected?.location ?? "");
    setState(() {
      _position = CameraPosition(
        target: targetLatLng,
        zoom: 15,
      );
    });
    if (holyWeekEventSelected?.location != "") {
      _addMarkerFromAddress(holyWeekEventSelected!.location);
    }
  }

  Future<void> _addMarkerFromAddress(String location) async {
    try {
      LatLng coordinates = await GeolocalitationFromDirection().getLatLngFromAddress(location);

      Marker marker = Marker(
        markerId: const MarkerId('marker_1'),
        position: coordinates,
      );

      setState(() {
        _markers = {marker};
        _errorMessage = "";
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  holyWeekEventSelected?.name.displayName ?? "Descanso",
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
                const Spacer(flex: 1),

              ],
            ),
          ),

          //MAP
          if (_errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ),
            SizedBox(
              height: 200,
              child: _position != null ? GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _position!,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: _markers,
              ) : const Center(
                child: CircularProgressIndicator(),
              ),
            ),

          //DIRECTION
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    holyWeekEventSelected?.location ?? "Descanso",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 5),
          CustomExpansionPanel(
            isExpanded: true,
            headerText: "Día y Hora",
            expandedText: holyWeekEventSelected?.date != null
              ? DateToString().dateString(holyWeekEventSelected!.date)
              : "Descanso"
          ),

          CustomExpansionPanel(
            headerText: "Duración", 
            expandedText: DurationToString.durationToString(holyWeekEventSelected?.duration ?? Duration.zero)
          ),

          CustomExpansionPanel(
            headerText: "Notas", 
            expandedText: holyWeekEventSelected?.moreInformation ?? "",
            isImportant: holyWeekEventSelected?.moreInformation != "",
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}