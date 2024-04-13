
import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/infrastructure/entities/musician_db.dart';

class MusicianMapper {
  static Musician musicianToDomain(MusicianDB musicianDB) => Musician(
    email: musicianDB.email, 
    name: musicianDB.name, 
    isAllowed: musicianDB.isAllowed, 
    isAdmin: musicianDB.isAdmin
  );

  static MusicianDB musicianToEntity(Musician musician) => MusicianDB(
    email: musician.email, 
    name: musician.name, 
    isAllowed: musician.isAllowed, 
    isAdmin: musician.isAdmin
  );
}
