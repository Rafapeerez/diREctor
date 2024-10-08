import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:director_app_tfg/domain/models/march.dart';
import 'package:director_app_tfg/domain/repositories/march_repository.dart';
import 'package:director_app_tfg/infrastructure/entities/march_db.dart';
import 'package:director_app_tfg/infrastructure/mappers/march_mapper.dart';

class FirebaseMarchDatasource implements MarchRepository {
  @override
  Future<List<March>> getAllMarchs() async {
    final CollectionReference marchCollection = FirebaseFirestore.instance.collection('marchas');
    final snapshot = await marchCollection.get();

    if (snapshot.size != 0) {
      try {
        final marchsList = snapshot.docs.map((doc) {
          final MarchDB marchDB = MarchDB.fromMap(doc.data() as Map<String, dynamic>);
          return MarchMapper.marchToDomain(marchDB);
        }).toList();
        return marchsList;
      } catch (e) {
        throw Exception('Error al obtener las marchas: $e');
      }
    } else {
      return List.empty();
    }
  }

  @override
  Future<March> saveMarch(March march) async {
    final CollectionReference marchCollection = FirebaseFirestore.instance.collection('marchas');

    try {
      final collectionSnapshot = await marchCollection.get();
      if (collectionSnapshot.size == 0) {
        await marchCollection.doc(march.id).set(MarchMapper.marchToEntity(march).toMap());
      } else {
        await marchCollection.doc(march.id).set(MarchMapper.marchToEntity(march).toMap());
      }
      return march;
    } catch (e) {
      throw Exception('Error al guardar la marcha: $e');
    }
  }

  @override
  Future<March> updateMarch(March march) async {
    try {
      DocumentReference marchRef = FirebaseFirestore.instance.collection('marchas').doc(march.id);
      await marchRef.update(MarchMapper.marchToEntity(march).toMap());
      return march;
    } catch (e) {
      return March.empty();
    }
  }

  @override
  Future<void> deleteMarch(String marchId) async {
    final CollectionReference marchsCollection = FirebaseFirestore.instance.collection('marchas');
    final snapshot = await marchsCollection.get();
    
    if ( snapshot.size != 0 ) {
      try{
        await marchsCollection.doc(marchId).delete();
      } catch (e) {
        throw Exception('Error al eliminar la marcha: $e');
      }
    }
  }
}


