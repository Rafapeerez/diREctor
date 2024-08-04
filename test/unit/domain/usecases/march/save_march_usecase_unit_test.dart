import 'package:director_app_tfg/domain/models/march.dart';
import 'package:director_app_tfg/aplication/usecases/march/save_march_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mother/info_object_mother.dart';
import 'march_repository_test.mocks.dart';

void main() {
  late SaveMarchUseCase useCase;
  late MockMarchRepository mockMarchRepository;

  setUp(() => {
    mockMarchRepository = MockMarchRepository(),
    useCase = SaveMarchUseCase(mockMarchRepository)
  });

  group("SaveMarchUseCase", () {
    test("should return the march saved when the call to the repository is successful ", () async {
      //GIVEN
      March march = InfoObjectMother.createMarch1();
      when(mockMarchRepository.saveMarch(march)).thenAnswer((_) async => march);

      //WHEN
      final result = await useCase.execute(march);

      //THEN
      verify(mockMarchRepository.saveMarch(march)).called(1);
      expect(march.id, result.id);
      expect(march.author, result.author);
      expect(march.link, result.link);
      expect(march.name, result.name);
      expect(march.number, result.number);
      expect(march.moreInformation, result.moreInformation);
    });

    test('should throw an exception when the call to the repository fails', () async {
      // GIVEN
      March march = InfoObjectMother.createMarch1();
      when(mockMarchRepository.saveMarch(march)).thenThrow(Exception('Error'));

      // WHEN & THEN
      expect(() => useCase.execute(march), throwsException);
      verify(mockMarchRepository.saveMarch(march)).called(1);
      verifyNoMoreInteractions(mockMarchRepository);
    });
  });
}
