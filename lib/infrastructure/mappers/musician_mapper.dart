
import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/infrastructure/entities/musician_db.dart';

class MusicianMapper {
  static Musician musicianToDomain(MusicianDB musicianDB) => Musician(
    id: musicianDB.id, 
    email: musicianDB.email, 
    name: musicianDB.name, 
    surname: musicianDB.surname, 
    isAllowed: musicianDB.isAllowed, 
    isAdmin: musicianDB.isAdmin
  );

  static MusicianDB musicianToEntity(Musician musician) => MusicianDB(
    id: musician.id, 
    email: musician.email, 
    name: musician.name, 
    surname: musician.surname, 
    isAllowed: musician.isAllowed, 
    isAdmin: musician.isAdmin
  );
}
