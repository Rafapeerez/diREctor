import 'package:director_app_tfg/domain/models/march.dart';
import 'package:director_app_tfg/domain/repositories/march_repository.dart';

class GetAllMarchsOrderByNumberUseCase {
  final MarchRepository _marchRepository;
  GetAllMarchsOrderByNumberUseCase(this._marchRepository);

  Future<List<March>> execute() async {
    List<March> marchsList = await _marchRepository.getAllMarchs();
    marchsList.sort(((a, b) => a.number.compareTo(b.number)));
    return marchsList;
  }
}
