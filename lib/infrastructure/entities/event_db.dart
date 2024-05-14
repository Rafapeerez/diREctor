import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:director_app_tfg/domain/models/march.dart';

class EventDB {
  final String id;
  final String type;
  final DateTime date;
  final String location;
  final List<March>? repertoire;
  final int duration;
  final List<dynamic> attendance;
  final String moreInformation;

  EventDB({
    required this.id, 
    required this.type,
    required this.date,
    required this.location,
    this.repertoire,
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
      'repetoire': repertoire,
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
}
