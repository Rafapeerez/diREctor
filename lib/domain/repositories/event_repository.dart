import 'package:director_app_tfg/domain/models/event.dart';

abstract class EventRepository {
  Future<Event> saveEvent(Event event);

  Future<List<Event>> getAllEvents();

  Future<Event> getEventById(String id);

  Future<Event> updateEvent(Event event);

  Future<void> deleteEvent(String eventId);
}
