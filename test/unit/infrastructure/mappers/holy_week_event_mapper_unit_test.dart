import 'package:director_app_tfg/domain/models/holy_week_event.dart';
import 'package:director_app_tfg/infrastructure/mappers/holy_week_event_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mother/info_object_mother.dart';

void main() {

  test("should convert an holy week event from domain to db", (){

    //GIVEN      
    HolyWeekEvent holyWeekEvent = InfoObjectMother.createHolyWeekEvent();

    //WHEN
    HolyWeekEvent mappedEvent = HolyWeekEventMapper.holyWeekEventToDomain(HolyWeekEventMapper.holyWeekEventToEntity(holyWeekEvent));

    //THEN
    expect(holyWeekEvent.name,              mappedEvent.name);
    expect(holyWeekEvent.imageURL,          mappedEvent.imageURL);
    expect(holyWeekEvent.id,                mappedEvent.id);
    expect(holyWeekEvent.type,              mappedEvent.type);
    expect(holyWeekEvent.date,              mappedEvent.date);
    expect(holyWeekEvent.location,          mappedEvent.location);
    expect(holyWeekEvent.duration,          mappedEvent.duration);
    expect(holyWeekEvent.moreInformation,   mappedEvent.moreInformation);
  
  });
}
