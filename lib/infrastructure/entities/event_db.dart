import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:director_app_tfg/domain/models/march.dart';
import 'package:director_app_tfg/infrastructure/entities/musician_db.dart';

class EventDB {
  final String id;
  final String type;
  final DateTime date;
  final String location;
  final List<March>? repertoire;
  final int duration;
  final List<MusicianDB>? attendance;
  final String moreInformation;

  EventDB({
    required this.id, 
    required this.type,
    required this.date,
    required this.location,
    this.repertoire,
    this.duration = 0,
    this.attendance,
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

    List<MusicianDB>? attendanceList;
    if (map['attendance'] != null) {
      attendanceList = (map['attendance'] as List<dynamic>)
          .map((item) => MusicianDB.fromMap(item))
          .toList();
    }
    
    return EventDB(
      id: map['id'], 
      type: map['type'], 
      date: dateValue, 
      location: map['location'],
      repertoire: map['repertoire'],
      duration: map['duration'],
      attendance: attendanceList,
      moreInformation: map['moreInformation']
    );
  }
}
