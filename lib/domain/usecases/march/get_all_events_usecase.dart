import 'package:director_app_tfg/domain/models/march.dart';
import 'package:director_app_tfg/domain/repositories/march_repository.dart';

class GetAllMarchsUseCase {
  final MarchRepository _marchRepository;
  GetAllMarchsUseCase(this._marchRepository);

  Future<List<March>> execute() async {
    List<March> marchsList = await _marchRepository.getAllMarchs();
    return marchsList;
  }
}
