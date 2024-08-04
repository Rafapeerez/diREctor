import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/aplication/usecases/event/get_all_events_usecacase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mother/info_object_mother.dart';
import 'event_repository_test.mocks.dart';

void main() {
  late GetAllEventsUseCase useCase;
  late MockEventRepository mockEventRepository;

  setUp(() {
    mockEventRepository = MockEventRepository();
    useCase = GetAllEventsUseCase(mockEventRepository);
  });

  group("GetAllEventsUseCase", () {
    test("should return a list of events when the call to the repository is successful", () async {
      //GIVEN
      final List<Event> eventList = [
        InfoObjectMother.createConcert(),
        InfoObjectMother.createProcesion()
      ];
      final List<Event> expectedList = List.from(eventList)..sort((a, b) => a.date.compareTo(b.date));

      final stream = Stream<List<Event>>.fromIterable([eventList]);
      when(mockEventRepository.getAllEvents()).thenAnswer((_) => stream);

      //WHEN
      final result = await useCase.execute().first;

      //THEN
      verify(mockEventRepository.getAllEvents()).called(1);
      expect(result, equals(expectedList));
    });

    test('should throw an exception when the call to the repository fails', () async {
      // GIVEN
      when(mockEventRepository.getAllEvents()).thenThrow(Exception('Error'));

      // WHEN & THEN
      expect(() => useCase.execute(), throwsException);
      verify(mockEventRepository.getAllEvents()).called(1);
      verifyNoMoreInteractions(mockEventRepository);
    });
  });
}
