import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:director_app_tfg/domain/repositories/musician_repository.dart';
import 'package:director_app_tfg/infrastructure/mappers/musician_mapper.dart';

import '../../domain/models/musician.dart';

class FirebaseMusicianDatasource implements MusicianRepository {
  final FirebaseFirestore _firestore;

  FirebaseMusicianDatasource(this._firestore);

  @override
  Future<Musician> saveMusician(Musician musician) async {
    try {
      await _firestore.collection('usuario').add(MusicianMapper.musicianToEntity(musician).toMap());
      return musician;
    } catch (e) {
      throw Exception('Error al guardar el usuario: $e');
    }
  }
  
}
