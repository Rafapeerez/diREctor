import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:director_app_tfg/domain/repositories/musician_repository.dart';
import 'package:director_app_tfg/infrastructure/mappers/musician_mapper.dart';

import '../../domain/models/musician.dart';

class FirebaseMusicianDatasource implements MusicianRepository {
  
@override
Future<Musician> saveMusician(Musician musician) async {
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('usuario');
  final snapshot = await usersCollection.get();

  if (snapshot.size == 0) {
    // Collection no exist, create an example 
    final exampleData = MusicianMapper.musicianToEntity(
      Musician(
        email: 'fisrtmusician',
        name: 'Fisrt Musician',
        surname: 'Fisrt Musician',
        isAllowed: false,
        isAdmin: false,
      ),
    ).toMap();
    await usersCollection.add(exampleData);
  }

  try {
    await usersCollection.doc(musician.email).set(MusicianMapper.musicianToEntity(musician).toMap());
    return musician;
  } catch (e) {
    throw Exception('Error al guardar el usuario: $e');
  }
}
}
