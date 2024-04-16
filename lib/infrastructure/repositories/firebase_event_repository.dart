import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/domain/repositories/event_repository.dart';
import 'package:director_app_tfg/infrastructure/datasources/firebase_event_datasource_impl.dart';

class FirebaseEventRepository extends EventRepository {
  final FirebaseEventDatasource datasource;
  FirebaseEventRepository(this.datasource);

  @override
  Future<List<Event>> getAllEvents() {
    return datasource.getAllEvents();
  }

  @override
  Future<Event> getEventById(String id) {
    return datasource.getEventById(id);
  }

  @override
  Future<Event> saveEvent(Event event) {
    return datasource.saveEvent(event);
  }

  @override
  Future<Event> updateEvent(Event event) {
    return datasource.updateEvent(event);
  }
}
