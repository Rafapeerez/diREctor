import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/domain/repositories/musician_repository.dart';

class UpdateMusicianUseCase {

  final MusicianRepository _musicianRepository;
  UpdateMusicianUseCase(this._musicianRepository);
  
  Future<Musician?> execute(Musician musician) async {
    Musician? musicianSaved = await _musicianRepository.updateMusician(musician);
    return musicianSaved;
  }
}
