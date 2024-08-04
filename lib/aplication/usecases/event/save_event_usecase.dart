import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/domain/repositories/event_repository.dart';

class SaveEventUseCase {

  final EventRepository _eventRepository;
  SaveEventUseCase(this._eventRepository);
  
  Future<Event> execute(Event event) async {
    Event eventSaved = await _eventRepository.saveEvent(event);
    return eventSaved;
  }
}
