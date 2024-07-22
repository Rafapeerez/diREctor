import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:director_app_tfg/domain/models/holy_week_event.dart';
import 'package:director_app_tfg/domain/repositories/holy_week_event_repository.dart';
import 'package:director_app_tfg/infrastructure/entities/holy_week_event_db.dart';
import 'package:director_app_tfg/infrastructure/mappers/holy_week_event_mapper.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  Future<String> uploadImageToStorage(Uint8List file, String eventId) async {
    final ref = FirebaseStorage.instance.ref().child("$eventId.png");
    final uploadTask = ref.putData(file);
    await uploadTask.whenComplete(() => {});
    return await ref.getDownloadURL();
  }

  @override
  Future<HolyWeekEvent> updateHolyWeekEvent(HolyWeekEvent updatedEvent) async {
    try {
      DocumentReference eventRef = FirebaseFirestore.instance.collection('semanaSanta').doc(updatedEvent.id);
      HolyWeekEventDB holyWeekEventDB = HolyWeekEventMapper.holyWeekEventToEntity(updatedEvent);
      Map<String, dynamic> eventData = holyWeekEventDB.toMap();
      
      await eventRef.update(eventData);

      return updatedEvent; 
    } catch (e) {
      throw Exception('Error al actualizar el evento: $e');
    }
  }
}
