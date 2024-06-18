import 'package:director_app_tfg/domain/models/enums/event_type_enum.dart';
import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/infrastructure/entities/event_db.dart';
import 'package:director_app_tfg/infrastructure/entities/musician_db.dart';
import 'package:director_app_tfg/infrastructure/mappers/event_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

void main() {

  test("should convert an event from db to domain", (){

    //GIVEN      
    Musician firstMusician = Musician.create(email: "prueba@gmail.com", name: "Prueba", isAllowed: true, isAdmin: true);
    Musician secondMusician = Musician.create(email: "prueba2@gmail.com", name: "Prueba2", isAllowed: true, isAdmin: true);
    List<String> musiciansList = [firstMusician.email, secondMusician.email];

    Event event = Event(
      id: const Uuid().v4(), 
      type: EventTypeEnum.concierto, 
      date: DateTime(2023, 2, 21, 18, 00), 
      location: "Puente Romano de Cordoba",
      duration: const Duration(hours: 2),
      attendance: musiciansList,
      moreInformation: "Note"
    );

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

  test("should convert an event from domain to db", (){

    //GIVEN

    MusicianDB firstMusician = MusicianDB(email: "prueba@gmail.com", name: "Prueba", isAllowed: true, isAdmin: true, fcm: 'prueba1');
    MusicianDB secondMusician = MusicianDB(email: "prueba2@gmail.com", name: "Prueba2", isAllowed: true, isAdmin: true, fcm: 'prueba2');
    List<MusicianDB> musiciansList = [firstMusician, secondMusician];

    EventDB entity = EventDB(
      id: const Uuid().v4(), 
      type: EventTypeEnum.concierto.displayName, 
      date: DateTime(2023, 2, 21, 18, 00), 
      location: "Puente Romano de Cordoba",
      duration: 2,
      attendance: musiciansList,
      moreInformation: "Note"
    );

    //WHEN
    Event mappedDomain = EventMapper.eventToDomain(entity);
    EventDB mappedEntity = EventMapper.eventToEntity(mappedDomain);

    //THEN
  
    expect(entity.id,                 mappedEntity.id);
    expect(entity.type,               mappedEntity.type);
    expect(entity.date,               mappedEntity.date);
    expect(entity.location,           mappedEntity.location);
    expect(entity.duration,           mappedEntity.duration);
    expect(entity.attendance.length, mappedEntity.attendance.length);
    expect(entity.moreInformation,    mappedEntity.moreInformation);
  
  });
}
