import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/domain/usecases/musician/get_musician_by_id_usecase.dart';
import 'package:director_app_tfg/domain/usecases/musician/save_musician_usecase.dart';
import 'package:director_app_tfg/infrastructure/datasources/firebase_musician_datasource_impl.dart';
import 'package:director_app_tfg/infrastructure/repositories/firebase_musician_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final musicianProvider = StateNotifierProvider<MusicianProvider, Musician?>((ref) {
  final saveMusicianUseCase = SaveMusicianUseCase(FirebaseMusicianRepository(FirebaseMusicianDatasource()));
  
  final getMusicianByIdUseCase = GetMusicianByIdUseCase(FirebaseMusicianRepository(FirebaseMusicianDatasource()));

  return MusicianProvider(saveMusicianUseCase, getMusicianByIdUseCase);
});

class MusicianProvider extends StateNotifier<Musician?> {
  
  final SaveMusicianUseCase _saveMusicianUseCase;
  final GetMusicianByIdUseCase _getMusicianByIdUseCase;

  MusicianProvider(this._saveMusicianUseCase, this._getMusicianByIdUseCase) : super(null);

  Future<void> saveMusician(Musician musician) async {
    try {
      await _saveMusicianUseCase.execute(musician);
      state = musician;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getMusicianById(String email) async {
    try {
      Musician? musician = await _getMusicianByIdUseCase.execute(email);
      state = musician;
    } catch (e) {
      rethrow;
    }
  }
}