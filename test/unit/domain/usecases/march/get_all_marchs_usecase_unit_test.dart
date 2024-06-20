import 'package:director_app_tfg/domain/usecases/march/get_all_marchs_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:director_app_tfg/domain/models/march.dart';
import '../../../mother/info_object_mother.dart';
import 'march_repository_test.mocks.dart';

void main() {
  late GetAllMarchsUseCase useCase;
  late MockMarchRepository mockMarchRepository;

  setUp(() {
    mockMarchRepository = MockMarchRepository();
    useCase = GetAllMarchsUseCase(mockMarchRepository);
  });

  group('GetAllMarchsUseCase', () {
    test('should return a list of marches when the call to the repository is successful', () async {
      // GIVEN
      final List<March> marchList = [
        InfoObjectMother.createMarch1(),
        InfoObjectMother.createMarch2(),
      ];
      when(mockMarchRepository.getAllMarchs()).thenAnswer((_) async => marchList);

      // WHEN
      final result = await useCase.execute();

      // THEN
      verify(mockMarchRepository.getAllMarchs()).called(1);
      expect(result.length, marchList.length);
      expect(result.first, marchList.first);
      expect(result[1], marchList[1]);
    });

    test('should throw an exception when the call to the repository fails', () async {
      // GIVEN
      when(mockMarchRepository.getAllMarchs()).thenThrow(Exception('Error'));

      // WHEN & THEN
      expect(() => useCase.execute(), throwsException);
      verify(mockMarchRepository.getAllMarchs()).called(1);
      verifyNoMoreInteractions(mockMarchRepository);
    });
  });
}
