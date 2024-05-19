import 'package:director_app_tfg/domain/repositories/march_repository.dart';

class DeleteMarchUseCase {

  final MarchRepository _marchRepository;
  DeleteMarchUseCase(this._marchRepository);
  
  Future<void> execute(String marchId) async {
    await _marchRepository.deleteMarch(marchId);
  }
}
