import 'package:director_app_tfg/domain/models/holy_week_event.dart';

abstract class HolyWeekEventRepository {
  Stream<List<HolyWeekEvent>> getAllHolyWeekEvents();

  Future<bool> changeToRestDay(String eventId);

  Future<HolyWeekEvent> updateHolyWeekEvent(String eventId, HolyWeekEvent event);

}
