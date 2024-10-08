import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/domain/models/musician.dart';

abstract class EventRepository {
  Future<Event> saveEvent(Event event);

  Stream<List<Event>> getAllEvents();

  Future<void> deleteEvent(String eventId);

  Future<Event> confirmAttendance(Musician musician, Event event);

  Future<bool> hasConfirmed(String email, String eventId);

  Future<Event> updateRepertoire(List<String> repertoire, Event event);

  Future<Event> updateEvent(String eventId, Event event);

  Future<bool> deleteMusicianFromEvent(String eventId, String email);
}
