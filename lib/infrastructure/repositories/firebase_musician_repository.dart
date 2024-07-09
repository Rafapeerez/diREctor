import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/domain/repositories/musician_repository.dart';
import 'package:director_app_tfg/infrastructure/datasources/firebase_musician_datasource_impl.dart';

class FirebaseMusicianRepository extends MusicianRepository {
  final FirebaseMusicianDatasource datasource;
  FirebaseMusicianRepository(this.datasource);

  @override
  Future<Musician> saveMusician(Musician musician) {
    return datasource.saveMusician(musician);
  }

  @override
  Future<Musician?> getMusicianByEmail(String email) {
    return datasource.getMusicianByEmail(email);
  }

  @override
  Future<List<Musician>> getAllMusicians() {
    return datasource.getAllMusicians();
  }

  @override
  Future<List<Musician>> getNotAllowedMusicians() {
    return datasource.getNotAllowedMusicians();
  }

  @override
  Future<Musician?> updateMusician(Musician musician) {
    return datasource.updateMusician(musician);
  }

  @override
  Future<bool> deleteMusician(String email) {
    return datasource.deleteMusician(email);
  }

  @override
  Future<int> countNotAllowedMusicians() {
    return datasource.countNotAllowedMusicians();
  }
  
  @override
  Future<int> incrementTotalEventsAttendance(String email) {
    return datasource.incrementTotalEventsAttendance(email);
  }
}
