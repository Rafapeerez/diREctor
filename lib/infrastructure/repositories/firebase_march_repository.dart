import 'package:director_app_tfg/domain/models/march.dart';
import 'package:director_app_tfg/domain/repositories/march_repository.dart';
import 'package:director_app_tfg/infrastructure/datasources/firebase_march_datasource_impl.dart';

class FirebaseMarchRepository extends MarchRepository {
  final FirebaseMarchDatasource datasource;
  FirebaseMarchRepository(this.datasource);

  @override
  Future<List<March>> getAllMarchs() {
    return datasource.getAllMarchs();
  }

  @override
  Future<March> saveMarch(March march) {
    return datasource.saveMarch(march);
  }

  @override
  Future<March> updateMarch(March march) {
    return datasource.updateMarch(march);
  }

  @override
  Future<void> deleteMarch(String marchId) {
    return datasource.deleteMarch(marchId);
  }
}
