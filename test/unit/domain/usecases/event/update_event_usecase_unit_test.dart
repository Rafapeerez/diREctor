import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/domain/usecases/event/update_event_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mother/info_object_mother.dart';
import 'event_repository_test.mocks.dart';

void main() {
  late UpdateEventUseCase useCase;
  late MockEventRepository mockEventRepository;

  setUp(() {
    mockEventRepository = MockEventRepository();
    useCase = UpdateEventUseCase(mockEventRepository);
  });

  group("UpdateEventUseCase", () {
    test("should return the event updated when the call to the repository is successful", () async {
      //GIVEN
      String eventId = "event123";
      Event event = InfoObjectMother.createConcert();

      when(mockEventRepository.updateEvent(eventId, event)).thenAnswer((_) async => event);

      //WHEN
      final result = await useCase.execute(eventId, event);

      //THEN
      verify(mockEventRepository.updateEvent(eventId, event)).called(1);
      expect(event.id, result.id);
      expect(event.date, result.date);
      expect(event.duration, result.duration);
      expect(event.location, result.location);
      expect(event.attendance, result.attendance);
      expect(event.type, result.type);
      expect(event.repertoire, result.repertoire);
      expect(event.moreInformation, result.moreInformation);

    });

    test('should throw an exception when the call to the repository fails', () async {
      // GIVEN
      String eventId = "event123";
      Event event = InfoObjectMother.createConcert();
      when(mockEventRepository.updateEvent(eventId, event)).thenThrow(Exception('Error'));

      // WHEN & THEN
      expect(() => useCase.execute(eventId, event), throwsException);
      verify(mockEventRepository.updateEvent(eventId, event)).called(1);
      verifyNoMoreInteractions(mockEventRepository);
    });
  });
}
