import 'package:director_app_tfg/domain/repositories/musician_repository.dart';

class CountNotAllowedMusiciansUseCase {
  final MusicianRepository _musicianRepository;
  CountNotAllowedMusiciansUseCase(this._musicianRepository);

  Future<int> execute() async {
    return await _musicianRepository.countNotAllowedMusicians();
  }
}
