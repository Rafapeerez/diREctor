import 'package:director_app_tfg/domain/models/holy_week_event.dart';
import 'package:director_app_tfg/domain/repositories/holy_week_event_repository.dart';

class GetAllHolyWeekEventsUseCase {
  final HolyWeekEventRepository _holyWeekEventRepository;
  GetAllHolyWeekEventsUseCase(this._holyWeekEventRepository);

  Stream<List<HolyWeekEvent>> execute() {
    return _holyWeekEventRepository.getAllHolyWeekEvents(); 
  }
}
