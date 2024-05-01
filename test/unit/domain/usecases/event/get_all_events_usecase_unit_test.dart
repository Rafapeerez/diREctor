import 'package:director_app_tfg/domain/models/enums/event_type_enum.dart';
import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/domain/usecases/event/get_all_events_usecacase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/domain/repositories/event_repository.dart';
import 'package:uuid/uuid.dart';

//I only did this use case test as an example because my use cases are "bypass" from datasource methods

class MockEventRepository extends Mock implements EventRepository {
  @override
  Future<List<Event>> getAllEvents() => super.noSuchMethod(
    Invocation.method(#getAllEvents, []),
    returnValue: Future.value(<Event>[]),
    returnValueForMissingStub: Future.value(<Event>[]),
  );
}

void main() {
  late GetAllEventsUseCase useCase;
  late MockEventRepository mockEventRepository;

  setUp(() {
    mockEventRepository = MockEventRepository();
    useCase = GetAllEventsUseCase(mockEventRepository);
  });

  test('execute should return a list of events', () async {
    
    // GIVEN
    Musician firstMusician = Musician.create(email: "prueba@gmail.com", name: "Prueba", isAllowed: true, isAdmin: true);
    Musician secondMusician = Musician.create(email: "prueba2@gmail.com", name: "Prueba2", isAllowed: true, isAdmin: true);
    List<Musician> musiciansList = [firstMusician, secondMusician];
    final mockEvents = [
      Event(
        id: const Uuid().v4(), 
        type: EventTypeEnum.concierto, 
        date: DateTime.now(), 
        location: "Location 1",
        duration: const Duration(hours: 2),
        attendance: musiciansList,
        moreInformation: "Note"
      ),
      Event(
        id: const Uuid().v4(), 
        type: EventTypeEnum.salidaProcesional, 
        date: DateTime.now(), 
        location: "Location 2",
        duration: const Duration(hours: 1),
        attendance: musiciansList,
        moreInformation: "Note"
      ),
    ];
    when(mockEventRepository.getAllEvents()).thenAnswer((_) async => mockEvents);

    // WHEN
    final result = await useCase.execute();

    // THEN
    expect(result, isA<List<Event>>());
    expect(result, equals(mockEvents));
  });

  test('execute should return an empty list if repository returns an empty list', () async {
    // GIVEN
    when(mockEventRepository.getAllEvents()).thenAnswer((_) async => []);

    // WHEN
    final result = await useCase.execute();

    // THEN
    expect(result, isA<List<Event>>());
    expect(result.isEmpty, true);
  });

  test('execute should throw an exception if repository throws an exception', () async {
    // GIVEN
    when(mockEventRepository.getAllEvents()).thenThrow(Exception('Error getting events'));

    // WHEN & THEN
    expect(() async => await useCase.execute(), throwsException);
  });
}