import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/infrastructure/mappers/event_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mother/info_object_mother.dart';

void main() {

  test("should convert an event from domain to db", (){

    //GIVEN      
    Musician firstMusician = InfoObjectMother.createJohnMusicianWithoutPermission();
    Musician secondMusician = InfoObjectMother.createAdmin();
    List<String> musiciansList = [firstMusician.email, secondMusician.email];

    Event event = InfoObjectMother.createConcertWithAttendance(musiciansList);

    //WHEN
    Event mappedEvent = EventMapper.eventToDomain(EventMapper.eventToEntity(event));

    //THEN
    expect(event.id,                mappedEvent.id);
    expect(event.type,              mappedEvent.type);
    expect(event.date,              mappedEvent.date);
    expect(event.location,          mappedEvent.location);
    expect(event.duration,          mappedEvent.duration);
    expect(event.attendance.length, mappedEvent.attendance.length);
    expect(event.repertoire,        mappedEvent.repertoire);
    expect(event.moreInformation,   mappedEvent.moreInformation);
  
  });
}
