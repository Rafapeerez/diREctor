import 'package:director_app_tfg/domain/models/march.dart';
import 'package:director_app_tfg/domain/repositories/march_repository.dart';

class UpdateMarchUseCase {

  final MarchRepository _marchRepository;
  UpdateMarchUseCase(this._marchRepository);
  
  Future<March> execute(March march) async {
    return await _marchRepository.updateMarch(march);
  }
}
