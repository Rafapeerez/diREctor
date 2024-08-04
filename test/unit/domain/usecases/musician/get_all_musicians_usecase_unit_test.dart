import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/aplication/usecases/musician/get_all_musicians_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mother/info_object_mother.dart';
import 'musician_repository_test.mocks.dart';

void main() {
  late GetAllMusiciansUseCase useCase;
  late MockMusicianRepository mockMusicianRepository;

  setUp(() {
    mockMusicianRepository = MockMusicianRepository();
    useCase = GetAllMusiciansUseCase(mockMusicianRepository);
  });

  group("GetAllMusiciansUseCase", () {
    test("should return a list of musicians when the call to the repository is successful", () async {
      //GIVEN
      final List<Musician> musicianList = [
        InfoObjectMother.createJohnMusicianWithoutPermission(),
        InfoObjectMother.createMarieMusicianWithPermission()
      ];
      when(mockMusicianRepository.getAllMusicians()).thenAnswer((_) async => musicianList);

      //WHEN
      final result = await useCase.execute();

      //THEN
      verify(mockMusicianRepository.getAllMusicians()).called(1);
      expect(result.length, musicianList.length);
      expect(result.first, musicianList.first);
      expect(result[1], musicianList[1]);
    });

    test('should throw an exception when the call to the repository fails', () async {
      // GIVEN
      when(mockMusicianRepository.getAllMusicians()).thenThrow(Exception('Error'));

      // WHEN & THEN
      expect(() => useCase.execute(), throwsException);
      verify(mockMusicianRepository.getAllMusicians()).called(1);
      verifyNoMoreInteractions(mockMusicianRepository);
    });
  });
}
