import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/domain/repositories/event_repository.dart';

class UpdateEventUseCase {

  final EventRepository _eventRepository;
  UpdateEventUseCase(this._eventRepository);
  
  Future<Event> execute(String eventId, Event event) async {
    return await _eventRepository.updateEvent(eventId, event);
  }
}
