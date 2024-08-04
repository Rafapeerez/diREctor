import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/aplication/usecases/musician/update_musician_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mother/info_object_mother.dart';
import 'musician_repository_test.mocks.dart';

void main() {
  late UpdateMusicianUseCase useCase;
  late MockMusicianRepository mockMusicianRepository;

  setUp(() {
    mockMusicianRepository = MockMusicianRepository();
    useCase = UpdateMusicianUseCase(mockMusicianRepository);
  });


  group("UpdateMusicianUseCase", () {
    test("should return the musician updated when the call to the repository is successful", () async {
      //GIVEN
      Musician musician = InfoObjectMother.createJohnMusicianWithoutPermission();
      when(mockMusicianRepository.updateMusician(musician)).thenAnswer((_) async => musician);

      //WHEN
      final result = await useCase.execute(musician);

      //THEN
      verify(mockMusicianRepository.updateMusician(musician)).called(1);
      expect(musician.email, result!.email);
      expect(musician.fcm, result.fcm);
      expect(musician.instrument, result.instrument);
      expect(musician.name, result.name);
      expect(musician.phoneNumber, result.phoneNumber);
      expect(musician.isAdmin, result.isAdmin);
    });

    test('should throw an exception when the call to the repository fails', () async {
      // GIVEN
      Musician musician = InfoObjectMother.createJohnMusicianWithoutPermission();
      when(mockMusicianRepository.updateMusician(musician)).thenThrow(Exception('Error'));

      // WHEN & THEN
      expect(() => useCase.execute(musician), throwsException);
      verify(mockMusicianRepository.updateMusician(musician)).called(1);
      verifyNoMoreInteractions(mockMusicianRepository);
    });
  });
}