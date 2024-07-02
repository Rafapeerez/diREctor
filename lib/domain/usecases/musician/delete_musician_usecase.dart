import 'package:director_app_tfg/domain/repositories/musician_repository.dart';

class DeleteMusicianUseCase {

  final MusicianRepository _musicianRepository;
  DeleteMusicianUseCase(this._musicianRepository);
  
  Future<bool> execute(String email) async {
    return await _musicianRepository.deleteMusician(email);
  }
}
