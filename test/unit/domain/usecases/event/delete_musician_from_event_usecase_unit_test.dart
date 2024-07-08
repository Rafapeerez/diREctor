import 'package:director_app_tfg/domain/usecases/event/delete_musician_from_event_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mother/info_object_mother.dart';
import 'event_repository_test.mocks.dart';

void main() {
  late DeleteMusicianFromEventUseCase useCase;
  late MockEventRepository mockEventRepository;

  setUp(() {
    mockEventRepository = MockEventRepository();
    useCase = DeleteMusicianFromEventUseCase(mockEventRepository);
  });

  group("DeleteMusicianFromEventUseCasse", () {
    test("should return true when the call to the repository is successful", () async {
      //GIVEN
      final attendance = ['email@example.com'];
      final event = InfoObjectMother.createConcertWithAttendance(attendance);
      when(mockEventRepository.deleteMusicianFromEvent(event.id, attendance[0])).thenAnswer((_) async => true);

      //WHEN
      final result = await useCase.execute(event.id, attendance[0]);

      //THEN
      verify(mockEventRepository.deleteMusicianFromEvent(event.id, attendance[0])).called(1);
      expect(result, true);
    });


    test('should throw an exception when the call to the repository fails', () async {
      // GIVEN
      final attendance = ['email@example.com'];
      final event = InfoObjectMother.createConcertWithAttendance(attendance);
      when(mockEventRepository.deleteMusicianFromEvent(event.id, attendance[0])).thenThrow(Exception('Error'));

      // WHEN & THEN
      expect(() => useCase.execute(event.id, attendance[0]), throwsException);
      verify(mockEventRepository.deleteMusicianFromEvent(event.id, attendance[0])).called(1);
      verifyNoMoreInteractions(mockEventRepository);
    });
  });
}
