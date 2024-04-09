import 'package:director_app_tfg/domain/entities/musician.dart';

abstract class MusicianRepository {
  
  Future<Musician> saveMusician(Musician musician);
  
}
