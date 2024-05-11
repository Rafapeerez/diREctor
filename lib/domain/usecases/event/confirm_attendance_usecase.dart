import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/domain/repositories/event_repository.dart';

class ConfirmAttendanceUseCase {

  final EventRepository _eventRepository;
  ConfirmAttendanceUseCase(this._eventRepository);
  
  Future<void> execute(Musician musician, Event event) async {
    await _eventRepository.confirmAttendance(musician, event);
  }
}
