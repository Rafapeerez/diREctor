import 'package:director_app_tfg/domain/models/march.dart';
import 'package:director_app_tfg/domain/repositories/march_repository.dart';
import 'package:director_app_tfg/domain/usecases/march/get_all_marchs_order_by_name_usecase.dart';
import 'package:director_app_tfg/domain/usecases/march/get_all_marchs_order_by_number_usecase.dart';
import 'package:director_app_tfg/domain/usecases/march/get_all_marchs_usecase.dart';
import 'package:director_app_tfg/domain/usecases/march/save_march_usecase.dart';
import 'package:director_app_tfg/infrastructure/datasources/firebase_march_datasource_impl.dart';
import 'package:director_app_tfg/infrastructure/repositories/firebase_march_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedMarchProvider = StateProvider<March>((ref) => March.empty());

final marchRepositoryProvider = Provider<MarchRepository>((ref) {
  return FirebaseMarchRepository(FirebaseMarchDatasource());
});

// final deleteMarchUseCaseProvider = Provider((ref) {
//   final marchRepository = ref.read(marchRepositoryProvider);
//   return DeleteMarchUseCase(marchRepository);
// });

// MARCH

final marchProvider = StateNotifierProvider<MarchProvider, March?>((ref) {
  final saveMarchUseCase = SaveMarchUseCase(FirebaseMarchRepository(FirebaseMarchDatasource()));

  return MarchProvider(saveMarchUseCase);
});

class MarchProvider extends StateNotifier<March?> {
  final SaveMarchUseCase _saveMarchUseCase;

  MarchProvider(
    this._saveMarchUseCase,
  ) : super(null);

  Future<void> saveMarch(March march) async {
    await _saveMarchUseCase.execute(march);
    state = march;
  }
}

// LIST

final marchsProvider = StateNotifierProvider<MarchsProvider, List<March>>((ref) {
  final getAllMarchsUseCase = GetAllMarchsUseCase(FirebaseMarchRepository(FirebaseMarchDatasource()));
  final getAllMarchsOrderByNumberUseCase = GetAllMarchsOrderByNumberUseCase(FirebaseMarchRepository(FirebaseMarchDatasource()));
  final getAllMarchsOrderByNameUseCase = GetAllMarchsOrderByNameUseCase(FirebaseMarchRepository(FirebaseMarchDatasource()));


  return MarchsProvider(getAllMarchsUseCase, getAllMarchsOrderByNumberUseCase, getAllMarchsOrderByNameUseCase);
});

class MarchsProvider extends StateNotifier<List<March>> {
  final GetAllMarchsUseCase _getAllMarchsUseCase;
  final GetAllMarchsOrderByNumberUseCase _getAllMarchsOrderByNumberUseCase;
  final GetAllMarchsOrderByNameUseCase _getAllMarchsOrderByNameUseCase;

  MarchsProvider(
    this._getAllMarchsUseCase,
    this._getAllMarchsOrderByNumberUseCase,
    this._getAllMarchsOrderByNameUseCase
  ) : super(List.empty());

  Future<void> getAllMarchs() async {
    List<March> marchsList = await _getAllMarchsUseCase.execute();
    state = marchsList;
  }

  Future<void> getAllMarchsOrderByNumber() async {
    List<March> marchsList = await _getAllMarchsOrderByNumberUseCase.execute();
    state = marchsList;
  }

  Future<void> getAllMarchsOrderByName() async {
    List<March> marchsList = await _getAllMarchsOrderByNameUseCase.execute();
    state = marchsList;
  }

  Future<void> updateMarchsList(March march) async {
    List<March> updatedList = [...state];
    if (updatedList.isEmpty) {
      updatedList = [march];
    } else {
      updatedList.add(march); 
    }
    state = updatedList;
  }

  Future<void> updateMarchsListAfterDelete(String marchId) async {
    List<March> updatedList = [...state];
    updatedList.removeWhere((march) => march.id == marchId);
    state = updatedList;
  }
}



