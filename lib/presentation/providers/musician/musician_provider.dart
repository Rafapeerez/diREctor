import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/domain/repositories/musician_repository.dart';
import 'package:director_app_tfg/domain/usecases/musician/count_not_allowed_musicians_usecase.dart';
import 'package:director_app_tfg/domain/usecases/musician/decrement_total_events_attendance_usecase.dart';
import 'package:director_app_tfg/domain/usecases/musician/delete_musician_usecase.dart';
import 'package:director_app_tfg/domain/usecases/musician/get_all_musicians_usecase.dart';
import 'package:director_app_tfg/domain/usecases/musician/get_musician_by_id_usecase.dart';
import 'package:director_app_tfg/domain/usecases/musician/get_not_allowed_musicians_usecase.dart';
import 'package:director_app_tfg/domain/usecases/musician/increment_total_events_attendance_usecase.dart';
import 'package:director_app_tfg/domain/usecases/musician/save_musician_usecase.dart';
import 'package:director_app_tfg/domain/usecases/musician/update_musician_usecase.dart';
import 'package:director_app_tfg/infrastructure/datasources/firebase_musician_datasource_impl.dart';
import 'package:director_app_tfg/infrastructure/repositories/firebase_musician_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final musicianRepositoryProvider = Provider<MusicianRepository>((ref) {
  return FirebaseMusicianRepository(FirebaseMusicianDatasource());
});



final deleteMusicianUseCaseProvider = Provider((ref) {
  final musicianRepository = ref.read(musicianRepositoryProvider);
  return DeleteMusicianUseCase(musicianRepository);
});


//INT

final countNotAllowedMusiciansProvider = StateNotifierProvider<CountMusicianProvider, int>((ref) {
  final useCase = CountNotAllowedMusiciansUseCase(FirebaseMusicianRepository(FirebaseMusicianDatasource()));
  
  return CountMusicianProvider(useCase);
});

class CountMusicianProvider extends StateNotifier<int> {
  final CountNotAllowedMusiciansUseCase _countNotAllowedMusiciansUseCase;

  CountMusicianProvider(
    this._countNotAllowedMusiciansUseCase,
  ) : super(0);

  Future<void> countNotAllowedMusicians() async {
    int count = await _countNotAllowedMusiciansUseCase.execute();
    state = count;
  }
}


final changeTotalEventsAttendanceProvider = StateNotifierProvider<IncrementTotalEventsAttendanceProvider, int>((ref) {
  final incrementTotalEventsAttendanceUseCase = IncrementTotalEventsAttendanceUseCase(FirebaseMusicianRepository(FirebaseMusicianDatasource()));
  final decrementTotalEventsAttendanceUseCase = DecrementTotalEventsAttendanceUseCase(FirebaseMusicianRepository(FirebaseMusicianDatasource()));
  

  return IncrementTotalEventsAttendanceProvider(incrementTotalEventsAttendanceUseCase, decrementTotalEventsAttendanceUseCase);
});

class IncrementTotalEventsAttendanceProvider extends StateNotifier<int> {
  final IncrementTotalEventsAttendanceUseCase _incrementTotalEventsAttendanceUseCase;
  final DecrementTotalEventsAttendanceUseCase _decrementTotalEventsAttendanceUseCase;

  IncrementTotalEventsAttendanceProvider(
    this._incrementTotalEventsAttendanceUseCase,
    this._decrementTotalEventsAttendanceUseCase
  ) : super(0);

  Future<void> incrementTotalEventsAttendance(String email) async {
    int total = await _incrementTotalEventsAttendanceUseCase.execute(email);
    state = total;
  }

  Future<void> decrementTotalEventsAttendance(String email) async {
    int total = await _decrementTotalEventsAttendanceUseCase.execute(email);
    state = total;
  }
}

//MUSICIAN

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