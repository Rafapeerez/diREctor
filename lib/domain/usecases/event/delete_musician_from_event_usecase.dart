import 'package:director_app_tfg/domain/repositories/event_repository.dart';

class DeleteMusicianFromEventUseCase {

  final EventRepository _eventRepository;
  DeleteMusicianFromEventUseCase(this._eventRepository);
  
  Future<bool> execute(String eventId, String email) async {
    return await _eventRepository.deleteMusicianFromEvent(eventId, email);
  }
}
