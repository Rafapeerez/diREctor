import 'package:director_app_tfg/domain/models/march.dart';
import 'package:director_app_tfg/domain/repositories/march_repository.dart';

class GetAllMarchsOrderByNameUseCase {
  final MarchRepository _marchRepository;
  GetAllMarchsOrderByNameUseCase(this._marchRepository);

  Future<List<March>> execute() async {
    List<March> marchsList = await _marchRepository.getAllMarchs();
    List<March> orderedList = List.from(marchsList); 
    orderedList.sort(((a, b) => a.name.compareTo(b.name))); 
    return orderedList; 
  }
}
