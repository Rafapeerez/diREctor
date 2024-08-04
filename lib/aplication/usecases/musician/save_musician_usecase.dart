import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/domain/repositories/musician_repository.dart';

class SaveMusicianUseCase {

  final MusicianRepository _musicianRepository;
  SaveMusicianUseCase(this._musicianRepository);
  
  Future<Musician> execute(Musician musician) async {
    Musician musicianSaved = await _musicianRepository.saveMusician(musician);
    return musicianSaved;
  }
}
