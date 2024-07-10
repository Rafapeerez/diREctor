import 'package:director_app_tfg/domain/models/enums/event_type_enum.dart';
import 'package:director_app_tfg/domain/models/enums/holy_week_name_enum.dart';
import 'package:director_app_tfg/domain/models/holy_week_event.dart';
import 'package:director_app_tfg/infrastructure/entities/holy_week_event.dart';

class HolyWeekEventMapper {
  static HolyWeekEvent holyWeekEventToDomain(HolyWeekEventDB holyWeekEventDB) {
    return HolyWeekEvent(
        name: HolyWeekNameEnum.fromDisplayName(holyWeekEventDB.holyWeekName),
        imageURL: holyWeekEventDB.imageURL,
        id: holyWeekEventDB.id,
        date: holyWeekEventDB.date,
        location: holyWeekEventDB.location,
        type: EventTypeEnum.salidaProcesional,
        duration: Duration(hours: holyWeekEventDB.duration),
        moreInformation: holyWeekEventDB.moreInformation);
  }

  static HolyWeekEventDB holyWeekEventToEntity(HolyWeekEvent holyWeekEvent) {
    return HolyWeekEventDB(
      id: holyWeekEvent.id, 
      type: holyWeekEvent.type.displayName, 
      date: holyWeekEvent.date, 
      location: holyWeekEvent.location, 
      holyWeekName: holyWeekEvent.name.displayName, 
      imageURL: holyWeekEvent.imageURL,
      duration: holyWeekEvent.duration.inHours,
      moreInformation: holyWeekEvent.moreInformation
    );
  }
}
