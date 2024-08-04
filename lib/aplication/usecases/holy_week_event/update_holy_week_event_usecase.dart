import 'package:director_app_tfg/domain/models/holy_week_event.dart';
import 'package:director_app_tfg/domain/repositories/holy_week_event_repository.dart';

class UpdateHolyWeekEventUseCase {
  final HolyWeekEventRepository _holyWeekEventRepository;
  UpdateHolyWeekEventUseCase(this._holyWeekEventRepository);

  Future<void> execute(HolyWeekEvent event) {
    return _holyWeekEventRepository.updateHolyWeekEvent(event); 
  }
}
