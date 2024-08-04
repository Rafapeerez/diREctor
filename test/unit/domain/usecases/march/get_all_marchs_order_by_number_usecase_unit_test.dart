import 'package:director_app_tfg/aplication/usecases/march/get_all_marchs_order_by_number_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:director_app_tfg/domain/models/march.dart';
import '../../../mother/info_object_mother.dart';
import 'march_repository_test.mocks.dart';

void main() {
  late GetAllMarchsOrderByNumberUseCase useCase;
  late MockMarchRepository mockMarchRepository;

  setUp(() {
    mockMarchRepository = MockMarchRepository();
    useCase = GetAllMarchsOrderByNumberUseCase(mockMarchRepository);
  });

  group('GetAllMarchsOrderByNumberUseCase', () {
    test('should return a list of marches order by number when the call to the repository is successful', () async {
      // GIVEN
      final List<March> marchList = [
        InfoObjectMother.createMarch3(),
        InfoObjectMother.createMarch2(),
        InfoObjectMother.createMarch1(),
      ];
      when(mockMarchRepository.getAllMarchs()).thenAnswer((_) async => marchList);

      // WHEN
      final result = await useCase.execute();

      // THEN
      verify(mockMarchRepository.getAllMarchs()).called(1);
      expect(result.length, marchList.length);
      expect(result[0].number, marchList[2].number); 
      expect(result[1].number, marchList[1].number); 
      expect(result[2].number, marchList[0].number);

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