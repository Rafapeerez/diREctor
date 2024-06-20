import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/domain/usecases/event/save_event_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mother/info_object_mother.dart';
import 'event_repository_test.mocks.dart';

void main() {
  late SaveEventUseCase useCase;
  late MockEventRepository mockEventRepository;

  setUp(() => {
    mockEventRepository = MockEventRepository(),
    useCase = SaveEventUseCase(mockEventRepository)
  });

  group("SaveEventUseCase", () { 
    test("should return the event saved when the call to the repository is successful ", () async {
      //GIVEN
      Event event = InfoObjectMother.createConcert();
      when(mockEventRepository.saveEvent(event)).thenAnswer((_) async  => event);

      //WHEN
      final result = await useCase.execute(event);

      //THEN
      verify(mockEventRepository.saveEvent(event)).called(1);
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
      Event event = InfoObjectMother.createConcert();
      when(mockEventRepository.saveEvent(event)).thenThrow(Exception('Error'));

      // WHEN & THEN
      expect(() => useCase.execute(event), throwsException);
      verify(mockEventRepository.saveEvent(event)).called(1);
      verifyNoMoreInteractions(mockEventRepository);
    });
    
  });
}
