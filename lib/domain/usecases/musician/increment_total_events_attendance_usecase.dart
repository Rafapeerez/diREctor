import 'package:director_app_tfg/domain/repositories/musician_repository.dart';

class IncrementTotalEventsAttendanceUseCase {
  final MusicianRepository _musicianRepository;
  IncrementTotalEventsAttendanceUseCase(this._musicianRepository);

  Future<int> execute(String email) async {
    return await _musicianRepository.incrementTotalEventsAttendance(email);
  }
}
