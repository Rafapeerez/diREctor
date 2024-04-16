import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/domain/usecases/event/get_all_events_usecacase.dart';
import 'package:director_app_tfg/infrastructure/datasources/firebase_event_datasource_impl.dart';
import 'package:director_app_tfg/infrastructure/repositories/firebase_event_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventsProvider = StateNotifierProvider<EventsProvider, List<Event>>((ref) {
  final getAllEventsUseCase = GetAllEventsUseCase(FirebaseEventRepository(FirebaseEventDatasource()));

  return EventsProvider(getAllEventsUseCase);
});

class EventsProvider extends StateNotifier<List<Event>> {
  
  final GetAllEventsUseCase _getAllEventsUseCase;

  EventsProvider(
    this._getAllEventsUseCase
  ) : super(List.empty());

  Future<void> getAllEvents() async {
    List<Event> eventsList = await _getAllEventsUseCase.execute();
    state = eventsList;
  }
}
