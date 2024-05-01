import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/domain/repositories/event_repository.dart';
import 'package:director_app_tfg/infrastructure/entities/event_db.dart';
import 'package:director_app_tfg/infrastructure/mappers/event_mapper.dart';

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
}
