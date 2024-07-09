
import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/infrastructure/entities/musician_db.dart';

class MusicianMapper {
  static Musician musicianToDomain(MusicianDB musicianDB) => Musician(
    email: musicianDB.email, 
    name: musicianDB.name, 
    instrument: musicianDB.instrument,
    phoneNumber: musicianDB.phoneNumber,
    isAllowed: musicianDB.isAllowed, 
    isAdmin: musicianDB.isAdmin,
    fcm: musicianDB.fcm,
    totalEventsAttendance: musicianDB.totalEventsAttendance
  );

  static MusicianDB musicianToEntity(Musician musician) => MusicianDB(
    email: musician.email, 
    name: musician.name, 
    instrument: musician.instrument,
    phoneNumber: musician.phoneNumber,
    isAllowed: musician.isAllowed, 
    isAdmin: musician.isAdmin,
    fcm: musician.fcm,
    totalEventsAttendance: musician.totalEventsAttendance
  );
}
