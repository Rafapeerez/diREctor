import 'package:director_app_tfg/domain/usecases/event/get_attendance_from_event_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'event_repository_test.mocks.dart';

void main() {
  late GetAttendanceFromEventUseCase useCase;
  late MockEventRepository mockEventRepository;

  setUp(() {
    mockEventRepository = MockEventRepository();
    useCase = GetAttendanceFromEventUseCase(mockEventRepository);
  });

  group("GetAttendanceFromEventUseCase", () {
    test("should return TRUE when event has attendance with an email given", () async {
      //GIVEN
      String email = "test@email.com";
      String eventID = "event1";

      when(mockEventRepository.hasConfirmed(email, eventID)).thenAnswer((_) async  => true);

      //WHEN
      final result = await useCase.execute(email, eventID); 

      //THEN
      verify(mockEventRepository.hasConfirmed(email, eventID)).called(1);
      expect(result, true);
    });

    test("should return FALSE when event has not attendance with an email given", () async {
      //GIVEN
      String email = "test@email.com";
      String eventID = "event2";

      when(mockEventRepository.hasConfirmed(email, eventID)).thenAnswer((_) async  => false);

      //WHEN
      final result = await useCase.execute(email, eventID); 

      //THEN
      verify(mockEventRepository.hasConfirmed(email, eventID)).called(1);
      expect(result, false);
    });

    test('should throw an exception when the call to the repository fails', () async {
      // GIVEN
      String email = "test@email.com";
      String eventID = "event2";
      when(mockEventRepository.hasConfirmed(email, eventID)).thenThrow(Exception('Error'));

      // WHEN & THEN
      expect(() => useCase.execute(email, eventID), throwsException);
      verify(mockEventRepository.hasConfirmed(email, eventID)).called(1);
      verifyNoMoreInteractions(mockEventRepository);
    });
  });
}
