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
  Future<bool> changeToRestDay(HolyWeekEvent event) async {
  try {
      DocumentReference eventRef = FirebaseFirestore.instance.collection('semanaSanta').doc(event.id);
      HolyWeekEvent restDay = HolyWeekEvent(
        date: DateTime(event.date.year,event.date.month,event.date.day, 0, 0, 0), 
        duration: Duration.zero,
        name: event.name,
        id: event.id,
        imageURL: "https://firebasestorage.googleapis.com/v0/b/director-2024-redencion.appspot.com/o/Descanso.png?alt=media&token=2fbb86b3-b765-4c31-b938-b2c45025cc7a",
        location: "",
        moreInformation: "",
        type: event.type
      );
      HolyWeekEventDB holyWeekEventDB = HolyWeekEventMapper.holyWeekEventToEntity(restDay);
      Map<String, dynamic> eventData = holyWeekEventDB.toMap();
      
      await eventRef.update(eventData);

      return true; 
    } catch (e) {
      return false;
    }
  }

  @override
  Future<HolyWeekEvent> updateHolyWeekEvent(String eventId, HolyWeekEvent event) {
    // TODO: implement updateEvent
    throw UnimplementedError();
  }

}
