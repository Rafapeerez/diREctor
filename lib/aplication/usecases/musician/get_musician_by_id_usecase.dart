import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/domain/repositories/musician_repository.dart';

class GetMusicianByIdUseCase {
  final MusicianRepository _musicianRepository;
  GetMusicianByIdUseCase(this._musicianRepository);

  Future<Musician?> execute(String email) async {
    Musician? musician = await _musicianRepository.getMusicianByEmail(email);
    return musician;
  }
}
