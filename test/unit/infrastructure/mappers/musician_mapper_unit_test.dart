import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/infrastructure/entities/musician_db.dart';
import 'package:director_app_tfg/infrastructure/mappers/musician_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  test("should convert musician from db to domain", (){

    //GIVEN
    Musician musician = Musician.create(
      email: "prueba@gmail.com", 
      name: "prueba", 
      isAllowed: false, 
      isAdmin: false
    );

    //WHEN
    Musician mappedMusician = MusicianMapper.musicianToDomain(MusicianMapper.musicianToEntity(musician));

    //THEN
    expect(musician.email,       mappedMusician.email);
    expect(musician.name,        mappedMusician.name);
    expect(musician.phoneNumber, mappedMusician.phoneNumber);
    expect(musician.instrument,  mappedMusician.instrument);
    expect(musician.isAdmin,     mappedMusician.isAdmin);
    expect(musician.isAllowed,   mappedMusician.isAllowed);
  
  });

  test("should convert musician from domain to db", (){

    //GIVEN
    MusicianDB entity = MusicianDB(
      email: "prueba@gmail.com", 
      name: "prueba", 
      isAllowed: false, 
      isAdmin: false
    );

    //WHEN
    MusicianDB mappedEntity = MusicianMapper.musicianToEntity(MusicianMapper.musicianToDomain(entity));

    //THEN
    expect(entity.email,       mappedEntity.email);
    expect(entity.name,        mappedEntity.name);
    expect(entity.phoneNumber, mappedEntity.phoneNumber);
    expect(entity.instrument,  mappedEntity.instrument);
    expect(entity.isAdmin,     mappedEntity.isAdmin);
    expect(entity.isAllowed,   mappedEntity.isAllowed);
  
  });
}
