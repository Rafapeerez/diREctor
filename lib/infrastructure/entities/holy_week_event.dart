import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:director_app_tfg/infrastructure/entities/event_db.dart';

class HolyWeekEventDB extends EventDB {
  final String holyWeekName;
  final String imageURL;

  HolyWeekEventDB({
    required String id,
    required String type,
    required DateTime date,
    required String location,
    int duration = 0,
    String moreInformation = " ",
    required this.holyWeekName,
    required this.imageURL
  }) : super(
    id: id,
    type: type,
    date: date,
    location: location,
    duration: duration,
    moreInformation: moreInformation,
  );

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'holyWeekName': holyWeekName,
      'imageURL': imageURL
    });
    return map;
  }

  static HolyWeekEventDB fromMap(Map<String, dynamic> map) {
    EventDB event = EventDB.fromMap(map);
    return HolyWeekEventDB(
      id: event.id,
      type: event.type,
      date: event.date,
      location: event.location,
      duration: event.duration,
      moreInformation: event.moreInformation,
      holyWeekName: map['holyWeekName'],
      imageURL: map['imageURL']
    );
  }

  factory HolyWeekEventDB.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    if (data == null) {
      throw Exception('Data from snapshot is null');
    }

    return HolyWeekEventDB(
      id: snapshot.id,
      type: data['type'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      location: data['location'] ?? '',
      duration: data['duration'] ?? 0,
      moreInformation: data['moreInformation'] ?? '',
      holyWeekName: data['holyWeekName'] ?? '',
      imageURL: data['imageURL'] ?? ''
    );
  }
}
