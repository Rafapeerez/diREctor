import 'package:director_app_tfg/domain/usecases/march/get_all_marchs_order_by_name_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:director_app_tfg/domain/models/march.dart';
import '../../../mother/info_object_mother.dart';
import 'march_repository_test.mocks.dart';

void main() {
  late GetAllMarchsOrderByNameUseCase useCase;
  late MockMarchRepository mockMarchRepository;

  setUp(() {
    mockMarchRepository = MockMarchRepository();
    useCase = GetAllMarchsOrderByNameUseCase(mockMarchRepository);
  });

  group('GetAllMarchsOrderByNumberUseCase', () {
    test('should return a list of marches order by number when the call to the repository is successful', () async {
      // GIVEN
      final List<March> maList = [
        InfoObjectMother.createMarch2(),
        InfoObjectMother.createMarch1(),
        InfoObjectMother.createMarch3(),
      ];
      when(mockMarchRepository.getAllMarchs()).thenAnswer((_) async => maList);

      // WHEN
      final List<March> result = await useCase.execute();

      // THEN

      expect(result.length, maList.length);
      expect(result.first.name, maList[2].name); // The first result element must be the third marchList element
      expect(result[1].name, maList[0].name); // The second result element must be the first marchList element
      expect(result[2].name, maList[1].name); // The third result element must be the second marchList element
      verify(mockMarchRepository.getAllMarchs()).called(1);
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