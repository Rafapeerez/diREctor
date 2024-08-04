import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/aplication/usecases/event/update_repertoire_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mother/info_object_mother.dart';
import 'event_repository_test.mocks.dart';

void main() {
  late UpdateRepertoireUseCase useCase;
  late MockEventRepository mockEventRepository;

  setUp(() {
    mockEventRepository = MockEventRepository();
    useCase = UpdateRepertoireUseCase(mockEventRepository);
  });


  group("UpdateRepertoireUseCase", () {
    test("should return the repertoire of an event updated when the call to the repository is successful", () async {
      //GIVEN
      List<String> listMarch = [
        InfoObjectMother.createMarch1().name,
        InfoObjectMother.createMarch2().name,
        InfoObjectMother.createMarch3().name
      ];
      Event event = InfoObjectMother.createConcertWithRepertoire(listMarch);
      when(mockEventRepository.updateRepertoire(listMarch, event)).thenAnswer((_) async => event);

      //WHEN
      final result = await useCase.execute(listMarch, event);

      //THEN
      verify(mockEventRepository.updateRepertoire(listMarch, event)).called(1);
      expect(event.id, result.id);
      expect(event.date, result.date);
      expect(event.duration, result.duration);
      expect(event.location, result.location);
      expect(event.attendance, result.attendance);
      expect(event.type, result.type);
      expect(event.repertoire[0], result.repertoire[0]);
      expect(event.repertoire[1], result.repertoire[1]);
      expect(event.repertoire[2], result.repertoire[2]);
      expect(event.moreInformation, result.moreInformation);
    });

    test('should throw an exception when the call to the repository fails', () async {
      // GIVEN
      List<String> listMarch = [
        InfoObjectMother.createMarch1().name,
        InfoObjectMother.createMarch2().name,
        InfoObjectMother.createMarch3().name
      ];
      Event event = InfoObjectMother.createConcertWithRepertoire(listMarch);
      when(mockEventRepository.updateRepertoire(listMarch, event)).thenThrow(Exception('Error'));

      // WHEN & THEN
      expect(() => useCase.execute(listMarch, event), throwsException);
      verify(mockEventRepository.updateRepertoire(listMarch, event)).called(1);
      verifyNoMoreInteractions(mockEventRepository);
    });
  });
}
