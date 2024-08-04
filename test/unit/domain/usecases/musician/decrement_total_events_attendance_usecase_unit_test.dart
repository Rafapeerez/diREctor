import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/aplication/usecases/musician/decrement_total_events_attendance_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mother/info_object_mother.dart';
import 'musician_repository_test.mocks.dart';

void main() {
  late DecrementTotalEventsAttendanceUseCase useCase;
  late MockMusicianRepository mockMusicianRepository;

  setUp(() => {
    mockMusicianRepository = MockMusicianRepository(),
    useCase = DecrementTotalEventsAttendanceUseCase(mockMusicianRepository)
  });

  group("DecrementTotalEventsAttendanceUseCase", () {
    test("should return the number of event that has the musician attend when the call to the repository is successful", () async {
      //GIVEN
      Musician musician = InfoObjectMother.createJohnMusicianWithoutPermission(); 
      when(mockMusicianRepository.decrementTotalEventsAttendance(musician.email)).thenAnswer((_) async => 1);
      
      //WHEN
      final result = await useCase.execute(musician.email);

      //THEN
      verify(mockMusicianRepository.decrementTotalEventsAttendance(musician.email)).called(1);
      expect(result, musician.totalEventsAttendance + 1);
    });

    test('should throw an exception when the call to the repository fails', () async {
      //GIVEN
      Musician musician = InfoObjectMother.createJohnMusicianWithoutPermission(); 
      when(mockMusicianRepository.decrementTotalEventsAttendance(musician.email)).thenThrow(Exception('Error'));
      
      //WHEN & THEN
      expect(() => useCase.execute(musician.email), throwsException);
      verify(mockMusicianRepository.decrementTotalEventsAttendance(musician.email)).called(1);
      verifyNoMoreInteractions(mockMusicianRepository);
    });
  });
}
