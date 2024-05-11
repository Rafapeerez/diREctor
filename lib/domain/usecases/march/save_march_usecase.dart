import 'package:director_app_tfg/domain/models/march.dart';
import 'package:director_app_tfg/domain/repositories/march_repository.dart';

class SaveMarchUseCase {

  final MarchRepository _marchRepository;
  SaveMarchUseCase(this._marchRepository);
  
  Future<March> execute(March march) async {
    March marchSaved = await _marchRepository.saveMarch(march);
    return marchSaved;
  }
}
