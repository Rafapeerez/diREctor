import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/aplication/usecases/musician/delete_musician_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mother/info_object_mother.dart';
import 'musician_repository_test.mocks.dart';

void main() {
  late DeleteMusicianUseCase useCase;
  late MockMusicianRepository mockMusicianRepository;

  setUp(() => {
    mockMusicianRepository = MockMusicianRepository(),
    useCase = DeleteMusicianUseCase(mockMusicianRepository)
  });

  group("DeleteMusicianUseCase", () {
    test("should delete the musician selected when the call to the repository is successful ", () async {
      //GIVEN
      Musician musician = InfoObjectMother.createJohnMusicianWithoutPermission();
      when(mockMusicianRepository.deleteMusician(musician.email)).thenAnswer((_) async => true);

      //WHEN
      final result = await useCase.execute(musician.email);

      //THEN
      verify(mockMusicianRepository.deleteMusician(musician.email)).called(1);
      expect(true, result);
    });

    test('should throw an exception when the call to the repository fails', () async {
      // GIVEN
      Musician musician = InfoObjectMother.createJohnMusicianWithoutPermission();
      when(mockMusicianRepository.deleteMusician(musician.email)).thenThrow(Exception('Error'));

      // WHEN & THEN
      expect(() => useCase.execute(musician.email), throwsException);
      verify(mockMusicianRepository.deleteMusician(musician.email)).called(1);
      verifyNoMoreInteractions(mockMusicianRepository);
    });
  });
}
