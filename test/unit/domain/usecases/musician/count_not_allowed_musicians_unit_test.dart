import 'package:director_app_tfg/domain/usecases/musician/count_not_allowed_musicians_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'musician_repository_test.mocks.dart';

void main() {
  late CountNotAllowedMusiciansUseCase useCase;
  late MockMusicianRepository mockMusicianRepository;

  setUp(() => {
    mockMusicianRepository = MockMusicianRepository(),
    useCase = CountNotAllowedMusiciansUseCase(mockMusicianRepository)
  });

  group("CountNotAllowedMusiciansUseCase", () {
    test("should count the not allowed musicians when the call to the repository is successful ", () async {
      //GIVEN
      //As we are testing use cases and the count is in the query this test is not very usefull
      when(mockMusicianRepository.countNotAllowedMusicians()).thenAnswer((_) async => 3);

      //WHEN
      final result = await useCase.execute();

      //THEN
      verify(mockMusicianRepository.countNotAllowedMusicians()).called(1);
      expect(3, result);
    });

    test('should throw an exception when the call to the repository fails', () async {
      // GIVEN
      when(mockMusicianRepository.countNotAllowedMusicians()).thenThrow(Exception('Error'));

      // WHEN & THEN
      expect(() => useCase.execute(), throwsException);
      verify(mockMusicianRepository.countNotAllowedMusicians()).called(1);
      verifyNoMoreInteractions(mockMusicianRepository);
    });
  });
}
