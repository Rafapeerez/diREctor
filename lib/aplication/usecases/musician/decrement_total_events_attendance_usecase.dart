import 'package:director_app_tfg/domain/repositories/musician_repository.dart';

class DecrementTotalEventsAttendanceUseCase {
  final MusicianRepository _musicianRepository;
  DecrementTotalEventsAttendanceUseCase(this._musicianRepository);

  Future<int> execute(String email) async {
    return await _musicianRepository.decrementTotalEventsAttendance(email);
  }
}
