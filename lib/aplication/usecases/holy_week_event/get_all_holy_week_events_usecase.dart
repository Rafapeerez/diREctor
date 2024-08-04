import 'package:director_app_tfg/domain/models/holy_week_event.dart';
import 'package:director_app_tfg/domain/repositories/holy_week_event_repository.dart';

class GetAllHolyWeekEventsOrderByDateUseCase {
  final HolyWeekEventRepository _holyWeekEventRepository;
  GetAllHolyWeekEventsOrderByDateUseCase(this._holyWeekEventRepository);

  Stream<List<HolyWeekEvent>> execute() {
    return _holyWeekEventRepository.getAllHolyWeekEvents().map((events) {
      events.sort((a, b) => a.date.compareTo(b.date));
      return events;
    });
  }
}
