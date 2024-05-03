import 'package:director_app_tfg/domain/models/march.dart';

abstract class MarchRepository {
  Future<March> saveMarch(March march);

  Future<List<March>> getAllMarchs();

  Future<March> updateMarch(March march);
}
