import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/domain/repositories/musician_repository.dart';

class GetNotAllowedMusiciansUseCase {
  final MusicianRepository _musicianRepository;
  GetNotAllowedMusiciansUseCase(this._musicianRepository);

  Future<List<Musician>> execute() async {
    List<Musician> musiciansList = await _musicianRepository.getNotAllowedMusicians();
    return musiciansList;
  }
}
