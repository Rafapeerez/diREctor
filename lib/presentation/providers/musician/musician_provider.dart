import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:director_app_tfg/domain/entities/musician.dart';
import 'package:director_app_tfg/domain/usecases/musician/save_musician_usecase.dart';
import 'package:director_app_tfg/infrastructure/datasources/firebase_musician_datasource_impl.dart';
import 'package:director_app_tfg/infrastructure/repositories/firebase_musician_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final musicianProvider = StateNotifierProvider<MusicianProvider, Musician?>((ref) {
  return MusicianProvider(SaveMusicianUseCase(FirebaseMusicianRepository(FirebaseMusicianDatasource(FirebaseFirestore.instance))));
});

class MusicianProvider extends StateNotifier<Musician?> {
  
  final SaveMusicianUseCase _saveMusicianUseCase;
  MusicianProvider(this._saveMusicianUseCase) : super(null);

  Future<void> saveMusician(Musician musician) async {
    try {
      await _saveMusicianUseCase.execute(musician);
      state = musician;
    } catch (e) {
      rethrow;
    }
  }
}
