import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/domain/usecases/musician/get_musician_by_id_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mother/info_object_mother.dart';
import 'musician_repository_test.mocks.dart';

void main() {
  late GetMusicianByIdUseCase useCase;
  late MockMusicianRepository mockMusicianRepository;

  setUp(() {
    mockMusicianRepository = MockMusicianRepository();
    useCase = GetMusicianByIdUseCase(mockMusicianRepository);
  });

  group("GetAllMusiciansUseCase", () {
    test("should return a musician when the call to the repository is successful", () async {
      //GIVEN
      Musician musician = InfoObjectMother.createJohnMusicianWithoutPermission();

      when(mockMusicianRepository.getMusicianByEmail(musician.email)).thenAnswer((_) async => musician);

      //WHEN
      final result = await useCase.execute(musician.email);

      //THEN
      verify(mockMusicianRepository.getMusicianByEmail(musician.email)).called(1);
      expect(result!.email, musician.email);
      expect(result.isAdmin, musician.isAdmin);
      expect(result.instrument, musician.instrument);
    });

    test('should throw an exception when the call to the repository fails', () async {
      // GIVEN
      Musician musician = InfoObjectMother.createJohnMusicianWithoutPermission();
      when(mockMusicianRepository.getMusicianByEmail(musician.email)).thenThrow(Exception('Error'));

      // WHEN & THEN
      expect(() => useCase.execute(musician.email), throwsException);
      verify(mockMusicianRepository.getMusicianByEmail(musician.email)).called(1);
      verifyNoMoreInteractions(mockMusicianRepository);
    });
  });
}
