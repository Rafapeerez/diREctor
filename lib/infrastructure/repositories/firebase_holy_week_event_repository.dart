import 'package:director_app_tfg/domain/models/holy_week_event.dart';
import 'package:director_app_tfg/domain/repositories/holy_week_event_repository.dart';
import 'package:director_app_tfg/infrastructure/datasources/firebase_holy_week_event_datasource_impl.dart';

class FirebaseHolyWeekEventRepository extends HolyWeekEventRepository {
  final FirebaseHolyWeekEventDatasource datasource;
  FirebaseHolyWeekEventRepository(this.datasource);

  @override
  Stream<List<HolyWeekEvent>> getAllHolyWeekEvents() {
    return datasource.getAllHolyWeekEvents();
  }

  @override
  Future<bool> changeToRestDay(String eventId) {
    return datasource.changeToRestDay(eventId);
  }

  @override
  Future<HolyWeekEvent> updateHolyWeekEvent(String eventId, HolyWeekEvent event) {
    return datasource.updateHolyWeekEvent(eventId, event);
  }
}
