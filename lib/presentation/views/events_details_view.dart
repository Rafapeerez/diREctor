import 'dart:async';
import 'package:director_app_tfg/config/helpers/date_to_string_helper.dart';
import 'package:director_app_tfg/config/helpers/duration_to_string_helper.dart';
import 'package:director_app_tfg/config/helpers/geolocalitation_from_direction_helper.dart';
import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/presentation/providers/event/event_provider.dart';
import 'package:director_app_tfg/presentation/providers/musician/musician_provider.dart';
import 'package:director_app_tfg/presentation/widgets/components/custom_expansion_panel.dart';
import 'package:director_app_tfg/presentation/widgets/custom_expansion_panel_attendance.dart';
import 'package:director_app_tfg/presentation/widgets/custom_expansion_panel_repertoire.dart';
import 'package:director_app_tfg/presentation/widgets/components/pop_up_menu_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:director_app_tfg/presentation/providers/user_provider.dart';

class EventsDetailsView extends ConsumerStatefulWidget {
  const EventsDetailsView({super.key});

  @override
  EventsDetailsViewState createState() => EventsDetailsViewState();
}

class EventsDetailsViewState extends ConsumerState<EventsDetailsView> {
  
  CameraPosition? _position;
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  late final Event eventSelected;

  Set<Marker> _markers = {};
  String _errorMessage = "";
  final ScrollController _scrollController = ScrollController();  

  @override
  void initState() {
    super.initState();  
    _initEventSelected(); 
  }

  void _initEventSelected() async {
    eventSelected = ref.read(selectedEventProvider);
    LatLng targetLatLng = await GeolocalitationFromDirection().getLatLngFromAddress(eventSelected.location);
    setState(() {
      _position = CameraPosition(
        target: targetLatLng,
        zoom: 15,
      );
    });
    _addMarkerFromAddress(eventSelected.location);
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
    final userState = ref.watch(userProvider);
    final attendanceProv = ref.watch(eventProvider.notifier);
    
    if (userState.user!.email != null) {
      ref.watch(attendanceProvider.notifier).hasConfirmed(userState.user!.email!, eventSelected.id);
    }
    bool hasConfirmedAttendance = ref.watch(attendanceProvider);

    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  eventSelected.type.displayName,
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
                const Spacer(flex: 1),
                if (userState.isAdmin) 
                  PopUpMenuButton(eventSelected: eventSelected),
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
                    eventSelected.location,
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
            expandedText: DateToString().dateString(eventSelected.date),
            scrollController: _scrollController,
          ),

          CustomExpansionPanel(
            headerText: "Duración", 
            expandedText: DurationToString.durationToString(eventSelected.duration),
            scrollController: _scrollController,
          ),

          userState.isAdmin 
            ? CustomExpansionPanelRepertoire(
              headerText: "Repertorio",
              scrollController: _scrollController,
            )
            : const SizedBox(),

          userState.isAdmin 
            ? CustomExpansionPanelAttendance(
              headerText: "Asistencia", 
              event: eventSelected,
              scrollController: _scrollController,
            ) 
            : const SizedBox(),

          CustomExpansionPanel(
            headerText: "Notas", 
            expandedText: eventSelected.moreInformation,
            scrollController: _scrollController,
          ),
          const SizedBox(height: 10),

          !hasConfirmedAttendance 
            ? Padding(
              padding: const EdgeInsets.all(10),
              child: FilledButton(
                onPressed: () async {
                  if (userState.user != null) {
                    Musician musician = Musician(
                      email: userState.user!.email!, 
                      name: userState.user!.displayName!,
                      isAllowed: true, 
                      isAdmin: userState.isAdmin, 
                      fcm: userState.fcm,
                      instrument: userState.instrument,
                      totalEventsAttendance: userState.totalEventsAttendance
                    );
                    await attendanceProv.confirmAttendance(musician, eventSelected);
                    await ref.watch(attendanceProvider.notifier).updateAttendance(true);
                    ref.read(changeTotalEventsAttendanceProvider.notifier).incrementTotalEventsAttendance(musician.email);
                  }
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green),
                ),
                child: const Text("Asisto"),
              ),
            )
            : const Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "Su confirmación ha sido registrada con éxito. Para cancelar hable con el director.",
                      maxLines: 2,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
