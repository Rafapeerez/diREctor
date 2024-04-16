import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/infrastructure/entities/event_db.dart';
import 'package:director_app_tfg/infrastructure/entities/musician_db.dart';
import 'package:director_app_tfg/infrastructure/mappers/musician_mapper.dart';

class EventMapper {
  static Event eventToDomain(EventDB eventDB) {
    List<Musician> attendance = eventDB.attendance.map(
      (musicianDB) => MusicianMapper.musicianToDomain(musicianDB)
    ).toList();

    return Event(
      id: eventDB.id, 
      type: eventDB.type, 
      date: eventDB.date, 
      location: eventDB.location,
      repertoire: eventDB.repertoire,
      duration: eventDB.duration,
      attendance: attendance,
      moreInformation: eventDB.moreInformation
    );
  } 

  static EventDB eventToEntity(Event event){
    List<MusicianDB> attendance = event.attendance.map(
      (musician) => MusicianMapper.musicianToEntity(musician)
    ).toList();
    
    return EventDB(
      id: event.id, 
      type: event.type, 
      date: event.date, 
      location: event.location,
      repertoire: event.repertoire,
      duration: event.duration,
      attendance: attendance,
      moreInformation: event.moreInformation
    );
  }
}
