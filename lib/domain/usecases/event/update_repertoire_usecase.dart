import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/domain/repositories/event_repository.dart';

class UpdateRepertoireUseCase {

  final EventRepository _eventRepository;
  UpdateRepertoireUseCase(this._eventRepository);
  
  Future<Event> execute(List<String> repertoire, Event event) async {
    return await _eventRepository.updateRepertoire(repertoire, event);
  }
}
