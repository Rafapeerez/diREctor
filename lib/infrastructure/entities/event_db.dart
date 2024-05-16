import 'package:cloud_firestore/cloud_firestore.dart';

class EventDB {
  final String id;
  final String type;
  final DateTime date;
  final String location;
  final List<dynamic> repertoire;
  final int duration;
  final List<dynamic> attendance;
  final String moreInformation;

  EventDB({
    required this.id, 
    required this.type,
    required this.date,
    required this.location,
    this.repertoire = const [],
    this.duration = 0,
    this.attendance = const [],
    this.moreInformation = " "
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'date': date,
      'location': location,
      'repertoire': repertoire,
      'duration': duration,
      'attendance': attendance,
      'moreInformation': moreInformation
    };
  }

  static EventDB fromMap(Map<String, dynamic> map){

    dynamic dateValue = map['date'];
    if (dateValue is Timestamp) {
      dateValue = dateValue.toDate();
    }
    
    return EventDB(
      id: map['id'], 
      type: map['type'], 
      date: dateValue, 
      location: map['location'],
      repertoire: map['repertoire'],
      duration: map['duration'],
      attendance: map['attendance'],
      moreInformation: map['moreInformation']
    );
  }

  factory EventDB.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    if (data == null) {
      throw Exception('Data from snapshot is null');
    }

    return EventDB(
      id: snapshot.id,
      type: data['type'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      location: data['location'] ?? '',
      repertoire: List<dynamic>.from(data['repertoire'] ?? []),
      duration: data['duration'] ?? 0,
      attendance: List<dynamic>.from(data['attendance'] ?? []),
      moreInformation: data['moreInformation'] ?? '',
    );
  }
}
