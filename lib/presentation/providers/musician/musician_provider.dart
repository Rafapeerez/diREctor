import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/domain/usecases/musician/get_all_musicians_usecase.dart';
import 'package:director_app_tfg/domain/usecases/musician/get_musician_by_id_usecase.dart';
import 'package:director_app_tfg/domain/usecases/musician/get_not_allowed_musicians_usecase.dart';
import 'package:director_app_tfg/domain/usecases/musician/save_musician_usecase.dart';
import 'package:director_app_tfg/domain/usecases/musician/update_musician_usecase.dart';
import 'package:director_app_tfg/infrastructure/datasources/firebase_musician_datasource_impl.dart';
import 'package:director_app_tfg/infrastructure/repositories/firebase_musician_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final musicianProvider = StateNotifierProvider<MusicianProvider, Musician?>((ref) {
  final saveMusicianUseCase = SaveMusicianUseCase(FirebaseMusicianRepository(FirebaseMusicianDatasource()));
  
  final getMusicianByIdUseCase = GetMusicianByIdUseCase(FirebaseMusicianRepository(FirebaseMusicianDatasource()));

  final updateMusicianUseCase = UpdateMusicianUseCase(FirebaseMusicianRepository(FirebaseMusicianDatasource()));

  return MusicianProvider(saveMusicianUseCase, getMusicianByIdUseCase, updateMusicianUseCase);
});

class MusicianProvider extends StateNotifier<Musician?> {
  
  final SaveMusicianUseCase _saveMusicianUseCase;
  final GetMusicianByIdUseCase _getMusicianByIdUseCase;
  final UpdateMusicianUseCase _updateMusicianUseCase;

  MusicianProvider(
    this._saveMusicianUseCase, 
    this._getMusicianByIdUseCase,
    this._updateMusicianUseCase
  ) : super(null);

  Future<void> saveMusician(Musician musician) async {
    await _saveMusicianUseCase.execute(musician);
    state = musician;
  }

  Future<void> getMusicianById(String email) async {
    Musician? musician = await _getMusicianByIdUseCase.execute(email);
    state = musician;
  }

  Future<void> updateMusician(Musician musician) async {
    Musician? musicianUpdated = await _updateMusicianUseCase.execute(musician);
    state = musicianUpdated;
  }
}


//LIST

final musiciansProvider = StateNotifierProvider<MusiciansProvider, List<Musician>>((ref) {
  final getAllMusiciansUseCase = GetAllMusiciansUseCase(FirebaseMusicianRepository(FirebaseMusicianDatasource()));
  final getNotAllowedMusiciansUseCase = GetNotAllowedMusiciansUseCase(FirebaseMusicianRepository(FirebaseMusicianDatasource()));

  return MusiciansProvider(getAllMusiciansUseCase, getNotAllowedMusiciansUseCase);
});

class MusiciansProvider extends StateNotifier<List<Musician>>{
  final GetAllMusiciansUseCase _getAllMusiciansUseCase;
  final GetNotAllowedMusiciansUseCase _getNotAllowedMusiciansUseCase;

  MusiciansProvider(
    this._getAllMusiciansUseCase,
    this._getNotAllowedMusiciansUseCase
  ) : super(List.empty());


  Future<void> getAllMusicians() async {
    List<Musician> musicianssList = await _getAllMusiciansUseCase.execute();
    state = musicianssList; 
  }

  Future<void> getNotAllowedMusicians() async {
    List<Musician> musicianssList = await _getNotAllowedMusiciansUseCase.execute();
    state = musicianssList; 
  }

  Future<void> updateNotAllowedList(Musician musician) async {
    List<Musician> updatedList = [...state];
    updatedList.removeWhere((m) => m.email == musician.email);
    state = updatedList;
  }
}