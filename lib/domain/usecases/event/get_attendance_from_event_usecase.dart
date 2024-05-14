
import 'package:director_app_tfg/domain/repositories/event_repository.dart';

class GetAttendanceFromEventUseCase {
  final EventRepository _eventRepository;
  GetAttendanceFromEventUseCase(this._eventRepository);

  Future<bool> execute(String email, String eventId) async {
    bool hasConfirmed = await _eventRepository.hasConfirmed(email, eventId);
    return hasConfirmed;
  }
}
