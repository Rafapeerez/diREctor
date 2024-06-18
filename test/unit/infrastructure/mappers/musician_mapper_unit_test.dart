import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/infrastructure/mappers/musician_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mother/info_object_mother.dart';

void main() {

  test("should convert musician from db to domain", (){

    //GIVEN
    Musician musician = InfoObjectMother.createJohnMusicianWithoutPermission();

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
}
