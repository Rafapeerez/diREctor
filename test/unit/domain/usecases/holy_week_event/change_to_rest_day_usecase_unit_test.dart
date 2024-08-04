import 'package:director_app_tfg/domain/models/holy_week_event.dart';
import 'package:director_app_tfg/aplication/usecases/holy_week_event/change_to_rest_day_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mother/info_object_mother.dart';
import 'holy_week_event_repository_test.mocks.dart';

void main() {
  late ChangeToRestDayUseCase useCase;
  late MockHolyWeekEventRepository mockHolyWeekEventRepository;

  setUp(() {
    mockHolyWeekEventRepository = MockHolyWeekEventRepository();
    useCase = ChangeToRestDayUseCase(mockHolyWeekEventRepository);
  });

  group("ChangeToRestDayUseCase", () {
    test("should return true if the holy week event has been changed to a rest day when the call to the repository is successful", () async {
      //GIVEN
      final HolyWeekEvent holyWeekEvent = InfoObjectMother.createHolyWeekEvent1();

      when(mockHolyWeekEventRepository.changeToRestDay(holyWeekEvent)).thenAnswer((_) async => true);

      //WHEN
      final result = await useCase.execute(holyWeekEvent);

      //THEN
      verify(mockHolyWeekEventRepository.changeToRestDay(holyWeekEvent)).called(1);
      expect(result, true);
    });

    test('should throw an exception when the call to the repository fails', () async {
      // GIVEN
      final HolyWeekEvent holyWeekEvent = InfoObjectMother.createHolyWeekEvent1();

      when(mockHolyWeekEventRepository.changeToRestDay(holyWeekEvent)).thenThrow(Exception('Error'));

      // WHEN & THEN
      expect(() => useCase.execute(holyWeekEvent), throwsException);
      verify(mockHolyWeekEventRepository.changeToRestDay(holyWeekEvent)).called(1);
      verifyNoMoreInteractions(mockHolyWeekEventRepository);
    });
  });
}
