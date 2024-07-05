import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/domain/repositories/event_repository.dart';
import 'package:director_app_tfg/infrastructure/datasources/firebase_event_datasource_impl.dart';

class FirebaseEventRepository extends EventRepository {
  final FirebaseEventDatasource datasource;
  FirebaseEventRepository(this.datasource);

  @override
  Future<List<Event>> getAllEvents() {
    return datasource.getAllEvents();
  }

  @override
  Future<Event> saveEvent(Event event) {
    return datasource.saveEvent(event);
  }

  @override
  Future<void> deleteEvent(String eventId) {
    return datasource.deleteEvent(eventId);
  }

  @override
  Future<Event> confirmAttendance(Musician musician, Event event) {
    return datasource.confirmAttendance(musician, event);
  }

  @override
  Future<bool> hasConfirmed(String email, String eventId) {
    return datasource.hasConfirmed(email, eventId);
  }

  @override
  Future<Event> updateRepertoire(List<String> repertoire, Event event) {
    return datasource.updateRepertoire(repertoire, event);
  }

  @override
  Future<Event> updateEvent(String eventId, Event event) {
    return datasource.updateEvent(eventId, event);
  }

  @override
  Future<bool> deleteMusicianFromEvent(String eventId, String email) {
    return datasource.deleteMusicianFromEvent(eventId, email);
  }
}
