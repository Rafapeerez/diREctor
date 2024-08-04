import 'package:director_app_tfg/domain/models/march.dart';
import 'package:director_app_tfg/aplication/usecases/march/update_march_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mother/info_object_mother.dart';
import 'march_repository_test.mocks.dart';

void main() {
  late UpdateMarchUseCase useCase;
  late MockMarchRepository mockMarchRepository;

  setUp(() {
    mockMarchRepository = MockMarchRepository();
    useCase = UpdateMarchUseCase(mockMarchRepository);
  });


  group("UpdateMarchUseCase", () {
    test("should return the march updated when the call to the repository is successful", () async {
      //GIVEN
      March march = InfoObjectMother.createMarch1();
      when(mockMarchRepository.updateMarch(march)).thenAnswer((_) async => march);

      //WHEN
      final result = await useCase.execute(march);

      //THEN
      verify(mockMarchRepository.updateMarch(march)).called(1);
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
      when(mockMarchRepository.updateMarch(march)).thenThrow(Exception('Error'));

      // WHEN & THEN
      expect(() => useCase.execute(march), throwsException);
      verify(mockMarchRepository.updateMarch(march)).called(1);
      verifyNoMoreInteractions(mockMarchRepository);
    });
  });
}
