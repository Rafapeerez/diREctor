import 'package:director_app_tfg/domain/models/holy_week_event.dart';
import 'package:director_app_tfg/domain/usecases/holy_week_event/get_all_holy_week_events_usecase.dart';
import 'package:director_app_tfg/infrastructure/datasources/firebase_holy_week_event_datasource_impl.dart';
import 'package:director_app_tfg/infrastructure/repositories/firebase_holy_week_event_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedHolyWeekEventProvider = StateProvider<HolyWeekEvent?>((ref) => HolyWeekEvent.empty());

final holyWeekEventsProvider = StreamProvider<List<HolyWeekEvent>>((ref) {
  final repository = FirebaseHolyWeekEventRepository(FirebaseHolyWeekEventDatasource());
  final useCase = GetAllHolyWeekEventsUseCase(repository);
  return useCase.execute();
});

