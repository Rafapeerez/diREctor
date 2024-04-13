import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/domain/repositories/musician_repository.dart';

class GetAllMusiciansUseCase {

  final MusicianRepository _musicianRepository;
  GetAllMusiciansUseCase(this._musicianRepository);
  
  Future<Stream<Musician>> execute() async {
    Stream<Musician> musiciansStream = await _musicianRepository.getAllMusicians();
    return musiciansStream;
  }
}
