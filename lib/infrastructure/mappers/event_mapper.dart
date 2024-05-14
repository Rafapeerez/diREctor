import 'package:director_app_tfg/domain/models/enums/event_type_enum.dart';
import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/infrastructure/entities/event_db.dart';

class EventMapper {
  static Event eventToDomain(EventDB eventDB) {
    List<String> attendance = [];
    attendance = eventDB.attendance.map((item) => item.toString()).toList();

    EventTypeEnum type;
    if (eventDB.type == "Concierto") {
      type = EventTypeEnum.concierto;
    } else {
      type = EventTypeEnum.salidaProcesional;
    }

    return Event(
      id: eventDB.id, 
      type: type, 
      date: eventDB.date, 
      location: eventDB.location,
      repertoire: eventDB.repertoire ?? [],
      duration: Duration( hours: eventDB.duration ),
      attendance: attendance,
      moreInformation: eventDB.moreInformation
    );
  } 

  static EventDB eventToEntity(Event event){
    List<dynamic> attendance = event.attendance.toList();
    
    return EventDB(
      id: event.id, 
      type: event.type.displayName, 
      date: event.date, 
      location: event.location,
      repertoire: event.repertoire,
      duration: event.duration.inHours,
      attendance: attendance,
      moreInformation: event.moreInformation
    );
  }
}
