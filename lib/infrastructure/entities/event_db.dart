import 'package:director_app_tfg/domain/models/enums/event_type_enum.dart';
import 'package:director_app_tfg/domain/models/march.dart';
import 'package:director_app_tfg/infrastructure/entities/musician_db.dart';

class EventDB {
  final String id;
  final EventTypeEnum type;
  final DateTime date;
  final String location;
  final List<March> repertoire;
  final Duration? duration;
  final List<MusicianDB> attendance;
  final String moreInformation;

  EventDB({
    required this.id, 
    required this.type,
    required this.date,
    required this.location,
    this.repertoire = const [],
    this.duration,
    this.attendance = const [],
    this.moreInformation = ""
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
    return EventDB(
      id: map[''], 
      type: map['type'], 
      date: map['date'], 
      location: map['location'],
      repertoire: map['repertoire'],
      duration: map['duration'],
      attendance: map['attendance'],
      moreInformation: map['moreInformation']
    );
  }
}
