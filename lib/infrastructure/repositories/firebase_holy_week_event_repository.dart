import 'dart:typed_data';

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
  Future<bool> changeToRestDay(HolyWeekEvent event) {
    return datasource.changeToRestDay(event);
  }

  @override
  Future<HolyWeekEvent> updateHolyWeekEvent(HolyWeekEvent event) {
    return datasource.updateHolyWeekEvent(event);
  }

  @override
  Future<String> uploadImageToStorage(Uint8List file, String eventId) {
    return datasource.uploadImageToStorage(file, eventId);
  }
}
