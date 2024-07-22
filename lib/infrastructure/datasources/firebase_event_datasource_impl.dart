import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/domain/repositories/event_repository.dart';
import 'package:director_app_tfg/infrastructure/entities/event_db.dart';
import 'package:director_app_tfg/infrastructure/mappers/event_mapper.dart';

class FirebaseEventDatasource implements EventRepository {
  @override
  Stream<List<Event>> getAllEvents() {
    return FirebaseFirestore.instance
      .collection('eventos')
      .snapshots()
      .map((snapshot) => 
        snapshot.docs.map((doc) => EventMapper.eventToDomain(EventDB.fromMap(doc.data()))).toList()
      );    
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

  @override
  Future<Event> confirmAttendance(Musician musician, Event event) async {    
    try {
      DocumentReference eventRef = FirebaseFirestore.instance.collection('eventos').doc(event.id);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(eventRef);
        if (snapshot.data() != null && snapshot.data() is Map<String, dynamic>) {
          Map<String, dynamic> eventData = (snapshot.data()! as Map<String, dynamic>);
          List<dynamic> attendanceList = eventData['attendance'];
          attendanceList.add(musician.email); 
          transaction.update(eventRef, {'attendance': attendanceList});
        }
      });

      return event;
    } catch (e) {
      return Event.empty();
    }
  }
  

  @override
  Future<bool> hasConfirmed(String email, String eventId) async {
    try {
      DocumentReference eventRef = FirebaseFirestore.instance.collection('eventos').doc(eventId);
      DocumentSnapshot snapshot = await eventRef.get();
      if (snapshot.exists) {
        Map<String, dynamic>? eventData = snapshot.data() as Map<String, dynamic>?;
        if (eventData != null && eventData.containsKey('attendance')) {
          List<dynamic> attendanceList = eventData['attendance'];

          bool isConfirmed = attendanceList.contains(email);

          return isConfirmed;
        } 
      }
      return false;
    } catch (e) {
      return false;
    }
  }
  
  @override
  Future<Event> updateRepertoire(List<String> repertoire, Event event) async {
    try {
      DocumentReference eventRef = FirebaseFirestore.instance.collection('eventos').doc(event.id);

      await eventRef.update({
        'repertoire': FieldValue.arrayUnion(repertoire) 
      });

      DocumentSnapshot snapshot = await eventRef.get();
      Event updatedEvent = EventMapper.eventToDomain(EventDB.fromSnapshot(snapshot));

      return updatedEvent;

    } catch (e) {
      return Event.empty();
    }
  }
  
  @override
  Future<Event> updateEvent(String eventId, Event event) async {
    try {
      DocumentReference eventRef = FirebaseFirestore.instance.collection('eventos').doc(eventId);
      await eventRef.update(EventMapper.eventToEntity(event).toMap());

      return event;
    } catch (e) {
      return Event.empty();
    }
  }
  
  @override
  Future<bool> deleteMusicianFromEvent(String eventId, String email) async {
    try {
      DocumentReference eventRef = FirebaseFirestore.instance.collection('eventos').doc(eventId);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(eventRef);
        if (snapshot.exists) {
          Map<String, dynamic>? eventData = snapshot.data() as Map<String, dynamic>?;
          if (eventData != null && eventData.containsKey('attendance')) {
            List<dynamic> attendanceList = eventData['attendance'];
            attendanceList.remove(email);

            transaction.update(eventRef, {'attendance': attendanceList});
          }
        } else {
          return false;
        }
      });

      return true;
    } catch (e) {
      return false;
    }
  }

}
