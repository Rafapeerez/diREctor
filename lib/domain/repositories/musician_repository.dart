import 'package:director_app_tfg/domain/models/musician.dart';

abstract class MusicianRepository {
  Future<Musician> saveMusician(Musician musician);

  Future<Musician?> getMusicianByEmail(String email);

  Future<Stream<Musician>> getAllMusicians();
}
