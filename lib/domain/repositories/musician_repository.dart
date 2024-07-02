import 'package:director_app_tfg/domain/models/musician.dart';

abstract class MusicianRepository {
  Future<Musician> saveMusician(Musician musician);

  Future<Musician?> getMusicianByEmail(String email);

  Future<List<Musician>> getAllMusicians();

  Future<List<Musician>> getNotAllowedMusicians();

  Future<Musician?> updateMusician(Musician musician);

  Future<bool> deleteMusician(String email);

  Future<int> countNotAllowedMusicians();
}
