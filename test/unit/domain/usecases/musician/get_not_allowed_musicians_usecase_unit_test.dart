import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/domain/usecases/musician/get_not_allowed_musicians_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mother/info_object_mother.dart';
import 'musician_repository_test.mocks.dart';

void main() {
  late GetNotAllowedMusiciansUseCase useCase;
  late MockMusicianRepository mockMusicianRepository;

  setUp(() {
    mockMusicianRepository = MockMusicianRepository();
    useCase = GetNotAllowedMusiciansUseCase(mockMusicianRepository);
  });

  group("GetNotAllowedMusiciansUseCase", () {
    test("should return a list of not allowed musicians when the call to the repository is successful", () async {
      //GIVEN
      final List<Musician> notAllowedMusicianList = [
        InfoObjectMother.createJohnMusicianWithoutPermission(),
      ];
      when(mockMusicianRepository.getNotAllowedMusicians()).thenAnswer((_) async => notAllowedMusicianList);

      //WHEN
      final result = await useCase.execute();

      //THEN
      verify(mockMusicianRepository.getNotAllowedMusicians()).called(1);
      expect(result.length, notAllowedMusicianList.length);
      expect(result.first, notAllowedMusicianList.first);
    });

    test('should throw an exception when the call to the repository fails', () async {
      // GIVEN
      when(mockMusicianRepository.getNotAllowedMusicians()).thenThrow(Exception('Error'));

      // WHEN & THEN
      expect(() => useCase.execute(), throwsException);
      verify(mockMusicianRepository.getNotAllowedMusicians()).called(1);
      verifyNoMoreInteractions(mockMusicianRepository);
    });
  });
}
