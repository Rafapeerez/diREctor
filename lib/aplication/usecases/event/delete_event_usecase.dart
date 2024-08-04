import 'package:director_app_tfg/domain/repositories/event_repository.dart';

class DeleteEventUseCase {

  final EventRepository _eventRepository;
  DeleteEventUseCase(this._eventRepository);
  
  Future<void> execute(String eventId) async {
    await _eventRepository.deleteEvent(eventId);
  }
}
