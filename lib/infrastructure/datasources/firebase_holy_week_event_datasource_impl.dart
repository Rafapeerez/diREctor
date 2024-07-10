import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:director_app_tfg/domain/models/holy_week_event.dart';
import 'package:director_app_tfg/domain/repositories/holy_week_event_repository.dart';
import 'package:director_app_tfg/infrastructure/entities/holy_week_event_db.dart';
import 'package:director_app_tfg/infrastructure/mappers/holy_week_event_mapper.dart';

class FirebaseHolyWeekEventDatasource implements HolyWeekEventRepository {
  
  @override
  Stream<List<HolyWeekEvent>> getAllHolyWeekEvents() {
    return FirebaseFirestore.instance
      .collection('semanaSanta')
      .snapshots()
      .map((snapshot) => 
        snapshot.docs.map((doc) => HolyWeekEventMapper.holyWeekEventToDomain(HolyWeekEventDB.fromMap(doc.data()))).toList()
      );
  }
  
  @override
  Future<bool> changeToRestDay(String eventId) {
    // TODO: implement changeToRestDay
    throw UnimplementedError();
  }

  @override
  Future<HolyWeekEvent> updateHolyWeekEvent(String eventId, HolyWeekEvent event) {
    // TODO: implement updateEvent
    throw UnimplementedError();
  }

}
