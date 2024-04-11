import 'package:director_app_tfg/domain/models/musician.dart';

abstract class MusicianRepository {
  
  Future<Musician> saveMusician(Musician musician);
  
}
