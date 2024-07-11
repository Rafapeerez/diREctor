import 'package:director_app_tfg/domain/models/holy_week_event.dart';
import 'package:director_app_tfg/domain/repositories/holy_week_event_repository.dart';

class ChangeToRestDayUseCase {
  final HolyWeekEventRepository _holyWeekEventRepository;
  ChangeToRestDayUseCase(this._holyWeekEventRepository);

  Future<bool> execute(HolyWeekEvent event) {
    return _holyWeekEventRepository.changeToRestDay(event); 
  }
}
