import 'package:director_app_tfg/domain/models/holy_week_event.dart';
import 'package:director_app_tfg/domain/usecases/holy_week_event/change_to_rest_day_usecase.dart';
import 'package:director_app_tfg/domain/usecases/holy_week_event/get_all_holy_week_events_usecase.dart';
import 'package:director_app_tfg/infrastructure/datasources/firebase_holy_week_event_datasource_impl.dart';
import 'package:director_app_tfg/infrastructure/repositories/firebase_holy_week_event_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedHolyWeekEventProvider = StateProvider<HolyWeekEvent?>((ref) => HolyWeekEvent.empty());


final firebaseHolyWeekEventDatasourceProvider = Provider<FirebaseHolyWeekEventDatasource>((ref) {
  return FirebaseHolyWeekEventDatasource();
});

final firebaseHolyWeekEventRepositoryProvider = Provider<FirebaseHolyWeekEventRepository>((ref) {
  final datasource = ref.read(firebaseHolyWeekEventDatasourceProvider);
  return FirebaseHolyWeekEventRepository(datasource);
});

final changeToRestDayUseCaseProvider = Provider<ChangeToRestDayUseCase>((ref) {
  final repository = ref.read(firebaseHolyWeekEventRepositoryProvider);
  return ChangeToRestDayUseCase(repository);
});

// final getAllHolyWeekEventsUseCaseProvider = Provider<GetAllHolyWeekEventsUseCase>((ref) {
//   final repository = ref.read(firebaseHolyWeekEventRepositoryProvider);
//   return GetAllHolyWeekEventsUseCase(repository);
// });


final holyWeekEventsProvider = StreamProvider<List<HolyWeekEvent>>((ref) {
  final repository = FirebaseHolyWeekEventRepository(FirebaseHolyWeekEventDatasource());
  final useCase = GetAllHolyWeekEventsOrderByDateUseCase(repository);
  return useCase.execute();
});

