import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/domain/repositories/event_repository.dart';

class GetAllEventsUseCase {
  final EventRepository _eventRepository;
  GetAllEventsUseCase(this._eventRepository);

  Stream<List<Event>> execute() {
    return _eventRepository.getAllEvents();
  }
}
