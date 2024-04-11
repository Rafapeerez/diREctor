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
}
