import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/domain/repositories/event_repository.dart';
import 'package:director_app_tfg/infrastructure/entities/event_db.dart';
import 'package:director_app_tfg/infrastructure/mappers/event_mapper.dart';

class FirebaseEventDatasource implements EventRepository {
  
  @override
  Future<List<Event>> getAllEvents() async {
    final CollectionReference usersCollection = FirebaseFirestore.instance.collection('eventos');
    final snapshot = await usersCollection.get();

    if (snapshot.size != 0) {
      try {
        final musiciansList = snapshot.docs.map((doc) {
          final EventDB eventDB = EventDB.fromMap(doc.data() as Map<String, dynamic>);
          return EventMapper.eventToDomain(eventDB);
        }).toList();

        return musiciansList;
      } catch (e) {
        throw Exception('Error al obtener los eventos: $e');
      }
    } 
    else{
      return List.empty();
    }
  }

  @override
  Future<Event> getEventById(String id) {
    // TODO: implement getEventById
    throw UnimplementedError();
  }

  @override
  Future<Event> saveEvent(Event event) {
    // TODO: implement saveEvent
    throw UnimplementedError();
  }

  @override
  Future<Event> updateEvent(Event event) {
    // TODO: implement updateEvent
    throw UnimplementedError();
  }

}
