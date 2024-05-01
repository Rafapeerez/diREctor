import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/domain/repositories/event_repository.dart';
import 'package:director_app_tfg/domain/usecases/event/delete_event_usecase.dart';
import 'package:director_app_tfg/domain/usecases/event/get_all_events_usecacase.dart';
import 'package:director_app_tfg/domain/usecases/event/save_event_usecase.dart';
import 'package:director_app_tfg/infrastructure/datasources/firebase_event_datasource_impl.dart';
import 'package:director_app_tfg/infrastructure/repositories/firebase_event_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventRepositoryProvider = Provider<EventRepository>((ref) {
  return FirebaseEventRepository(FirebaseEventDatasource());
});

final selectedEventIdProvider = StateProvider<String>((ref) => "");

final deleteEventUseCaseProvider = Provider((ref) {
  final eventRepository = ref.read(eventRepositoryProvider);
  return DeleteEventUseCase(eventRepository);
});


//EVENT

final eventProvider = StateNotifierProvider<EventProvider, Event?>((ref) {
  final saveEventUseCase = SaveEventUseCase(FirebaseEventRepository(FirebaseEventDatasource()));

  return EventProvider(saveEventUseCase);
});

class EventProvider extends StateNotifier<Event?> {
  final SaveEventUseCase _saveEventUseCase;

  EventProvider(
    this._saveEventUseCase,
  ) : super(null);

  Future<void> saveEvent(Event event) async {
    await _saveEventUseCase.execute(event);
    state = event;
  }
}

//LIST

final eventsProvider = StateNotifierProvider<EventsProvider, List<Event>>((ref) {
  final getAllEventsUseCase = GetAllEventsUseCase(FirebaseEventRepository(FirebaseEventDatasource()));

  return EventsProvider(getAllEventsUseCase);
});

class EventsProvider extends StateNotifier<List<Event>> {
  final GetAllEventsUseCase _getAllEventsUseCase;

  EventsProvider(this._getAllEventsUseCase) : super(List.empty());

  Future<void> getAllEvents() async {
    List<Event> eventsList = await _getAllEventsUseCase.execute();
    state = eventsList;
  }

  Future<void> updateEventsList(Event event) async {
    List<Event> updatedList = [...state];
    if (updatedList.isEmpty) {
      updatedList = [event];
    } else {
      updatedList.add(event); 
    }
    state = updatedList;
  }

  Future<void> updateEventsListAfterDelete(String eventId) async {
    List<Event> updatedList = [...state];
    updatedList.removeWhere((event) => event.id == eventId);
    state = updatedList;
  }
}



