import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/domain/repositories/event_repository.dart';
import 'package:director_app_tfg/infrastructure/entities/event_db.dart';
import 'package:director_app_tfg/infrastructure/mappers/event_mapper.dart';
import 'package:director_app_tfg/infrastructure/mappers/musician_mapper.dart';

class FirebaseEventDatasource implements EventRepository {
  @override
  Future<List<Event>> getAllEvents() async {
    final CollectionReference eventsCollection = FirebaseFirestore.instance.collection('eventos');
    final snapshot = await eventsCollection.get();

    if (snapshot.size != 0) {
      try {
        final eventsList = snapshot.docs.map((doc) {
          final EventDB eventDB = EventDB.fromMap(doc.data() as Map<String, dynamic>);
          return EventMapper.eventToDomain(eventDB);
        }).toList();
        return eventsList;
      } catch (e) {
        throw Exception('Error al obtener los eventos: $e');
      }
    } else {
      return List.empty();
    }
  }

  @override
  Future<Event> getEventById(String id) {
    // TODO: implement getEventById
    throw UnimplementedError();
  }

  @override
  Future<Event> saveEvent(Event event) async {
    final CollectionReference eventsCollection = FirebaseFirestore.instance.collection('eventos');

    try {
      final collectionSnapshot = await eventsCollection.get();
      if (collectionSnapshot.size == 0) {
        // Collection NO exist
        await eventsCollection.doc(event.id).set(EventMapper.eventToEntity(event).toMap());
      } else {
        // Collection exist
        await eventsCollection.doc(event.id).set(EventMapper.eventToEntity(event).toMap());
      }
      return event;
    } catch (e) {
      throw Exception('Error al guardar el evento: $e');
    }
  }

  @override
  Future<Event> updateEvent(Event event) {
    // TODO: implement updateEvent
    throw UnimplementedError();
  }
  
  @override
  Future<void> deleteEvent(String eventId) async {
    final CollectionReference eventsCollection = FirebaseFirestore.instance.collection('eventos');
    final snapshot = await eventsCollection.get();
    
    if ( snapshot.size != 0 ) {
      try{
        await eventsCollection.doc(eventId).delete();
      } catch (e) {
        throw Exception('Error al eliminar el evento: $e');
      }
    }
  }
  
      // try {
    //   final CollectionReference eventsCollection = FirebaseFirestore.instance.collection('eventos');
    //   final query = eventsCollection.doc(event.id);
    //   EventDB eventDB = EventMapper.eventToEntity(event);

    //   eventDB.attendance!.add(MusicianMapper.musicianToEntity(musician));
    //   Event eventUpdated = EventMapper.eventToDomain(eventDB);
    //   print(eventUpdated.attendance[0].email + eventUpdated.attendance[0].name + eventUpdated.attendance[0].instrument + eventUpdated.attendance[0].phoneNumber);
    //   await query.set(EventMapper.eventToEntity(eventUpdated).toMap(), SetOptions(merge: true));

    //   return event;
    // } catch (e) {
    //   throw Exception('Error al confirmar la asistencia: $e');
    // }

  @override
  Future<Event> confirmAttendance(Musician musician, Event event) async {
    try {
      final DocumentReference docRef = FirebaseFirestore.instance.collection('coleccion').doc(event.id);
      await docRef.update({"attendance": MusicianMapper.musicianToEntity(musician)});
      return event;
    } catch (e) {
      print('Error al actualizar el campo: $e');
      throw Exception('Error al confirmar la asistencia');
    }
  }

}
