import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/domain/repositories/event_repository.dart';
import 'package:director_app_tfg/domain/usecases/event/confirm_attendance_usecase.dart';
import 'package:director_app_tfg/domain/usecases/event/delete_event_usecase.dart';
import 'package:director_app_tfg/domain/usecases/event/delete_musician_from_event_usecase.dart';
import 'package:director_app_tfg/domain/usecases/event/get_all_events_usecacase.dart';
import 'package:director_app_tfg/domain/usecases/event/get_attendance_from_event_usecase.dart';
import 'package:director_app_tfg/domain/usecases/event/save_event_usecase.dart';
import 'package:director_app_tfg/domain/usecases/event/update_event_usecase.dart';
import 'package:director_app_tfg/domain/usecases/event/update_repertoire_usecase.dart';
import 'package:director_app_tfg/infrastructure/datasources/firebase_event_datasource_impl.dart';
import 'package:director_app_tfg/infrastructure/repositories/firebase_event_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final eventRepositoryProvider = Provider<EventRepository>((ref) {
  return FirebaseEventRepository(FirebaseEventDatasource());
});

final deleteEventUseCaseProvider = Provider((ref) {
  final eventRepository = ref.read(eventRepositoryProvider);
  return DeleteEventUseCase(eventRepository);
});


// SELECTED EVENT

final selectedEventProvider = StateNotifierProvider<SelectedEventNotifier, Event>((ref) {
  return SelectedEventNotifier();
});


class SelectedEventNotifier extends StateNotifier<Event> {
  SelectedEventNotifier() : super(Event.empty());

  void setEvent(Event event) {
    state = event;
  }

  void removeAttendee(String email) {
    state = Event(
      id: state.id,
      attendance: state.attendance.where((a) => a != email).toList(),
      date: state.date,
      location: state.location,
      type: state.type,
      duration: state.duration,
      moreInformation: state.moreInformation,
      repertoire: state.repertoire
    );
  }

  void updateAttendance(List<String> newAttendance) {
    state = Event(
      id: state.id,
      attendance: newAttendance,
      date: state.date,
      location: state.location,
      type: state.type,
      duration: state.duration,
      moreInformation: state.moreInformation,
      repertoire: state.repertoire
    );
  }

  void updateEvent(Event newEvent) {
    state = newEvent;
  }
}

//EVENT

final eventProvider = StateNotifierProvider<EventProvider, Event?>((ref) {
  final saveEventUseCase = SaveEventUseCase(FirebaseEventRepository(FirebaseEventDatasource()));
  final confirmAttendanceUseCase = ConfirmAttendanceUseCase(FirebaseEventRepository(FirebaseEventDatasource()));
  final updateRepertoireUseCase = UpdateRepertoireUseCase(FirebaseEventRepository(FirebaseEventDatasource()));
  final updateEventUseCase = UpdateEventUseCase(FirebaseEventRepository(FirebaseEventDatasource()));

  return EventProvider(saveEventUseCase, confirmAttendanceUseCase, updateRepertoireUseCase, updateEventUseCase);
});

class EventProvider extends StateNotifier<Event?> {
  final SaveEventUseCase _saveEventUseCase;
  final ConfirmAttendanceUseCase _confirmAttendanceUseCase;
  final UpdateRepertoireUseCase _updateRepertoireUseCase;
  final UpdateEventUseCase _updateEventUseCase;

  EventProvider(
    this._saveEventUseCase,
    this._confirmAttendanceUseCase,
    this._updateRepertoireUseCase,
    this._updateEventUseCase
  ) : super(null);

  Future<void> saveEvent(Event event) async {
    await _saveEventUseCase.execute(event);
    state = event;
  }

  Future<void> confirmAttendance(Musician musician, Event event) async {
    await _confirmAttendanceUseCase.execute(musician, event);
    state = event;
  }

  Future<Event> updateRepertoire(List<String> repertoire, Event event) async {
    return await _updateRepertoireUseCase.execute(repertoire, event);
  }

  Future<Event> updateEvent(String eventId, Event event) async {
    return await _updateEventUseCase.execute(eventId, event);
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

// ATTENDANCE

final attendanceProvider = StateNotifierProvider<AttendanceProvider, bool>((ref){
  final getAttendanceFromEventUseCase = GetAttendanceFromEventUseCase(FirebaseEventRepository(FirebaseEventDatasource()));
  final deleteMusicianFromEventUseCase = DeleteMusicianFromEventUseCase(FirebaseEventRepository(FirebaseEventDatasource()));
  
  return AttendanceProvider(getAttendanceFromEventUseCase, deleteMusicianFromEventUseCase);
});

class AttendanceProvider extends StateNotifier<bool>{
  
  final GetAttendanceFromEventUseCase _getAttendanceFromEventUseCase;
  final DeleteMusicianFromEventUseCase _deleteMusicianFromEventUseCase;

  AttendanceProvider(
    this._getAttendanceFromEventUseCase,
    this._deleteMusicianFromEventUseCase
  ) : super(false);

  Future<bool> hasConfirmed(String email, String eventId) async {
    bool hasConfirmed = await _getAttendanceFromEventUseCase.execute(email, eventId);
    state = hasConfirmed;
    return hasConfirmed;
  }

  Future<void> updateAttendance (bool hasConfirmed) async {
    state = hasConfirmed;
  }

  Future<bool> deleteMusicianFromEvent(String eventId, String email) async {
    bool isDeleted = await _deleteMusicianFromEventUseCase.execute(eventId, email);
    state = isDeleted;
    return isDeleted;
  }

}

