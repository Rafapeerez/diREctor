import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/domain/usecases/musician/increment_total_events_attendance_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mother/info_object_mother.dart';
import 'musician_repository_test.mocks.dart';

void main() {
  late IncrementTotalEventsAttendanceUseCase useCase;
  late MockMusicianRepository mockMusicianRepository;

  setUp(() => {
    mockMusicianRepository = MockMusicianRepository(),
    useCase = IncrementTotalEventsAttendanceUseCase(mockMusicianRepository)
  });

  group("IncrementTotalEventsAttendanceUseCase", () {
    test("should return the number of event that has the musician attend when the call to the repository is successful", () async {
      //GIVEN
      Musician musician = InfoObjectMother.createJohnMusicianWithoutPermission(); 
      when(mockMusicianRepository.incrementTotalEventsAttendance(musician.email)).thenAnswer((_) async => 1);
      
      //WHEN
      final result = await useCase.execute(musician.email);

      //THEN
      verify(mockMusicianRepository.incrementTotalEventsAttendance(musician.email)).called(1);
      expect(result, musician.totalEventsAttendance + 1);
    });

    test('should throw an exception when the call to the repository fails', () async {
      //GIVEN
      Musician musician = InfoObjectMother.createJohnMusicianWithoutPermission(); 
      when(mockMusicianRepository.incrementTotalEventsAttendance(musician.email)).thenThrow(Exception('Error'));
      
      //WHEN & THEN
      expect(() => useCase.execute(musician.email), throwsException);
      verify(mockMusicianRepository.incrementTotalEventsAttendance(musician.email)).called(1);
      verifyNoMoreInteractions(mockMusicianRepository);
    });
  });
}
