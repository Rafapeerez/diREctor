import 'package:director_app_tfg/domain/models/holy_week_event.dart';
import 'package:director_app_tfg/aplication/usecases/holy_week_event/update_holy_week_event_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mother/info_object_mother.dart';
import 'holy_week_event_repository_test.mocks.dart';

void main() {
  late UpdateHolyWeekEventUseCase useCase;
  late MockHolyWeekEventRepository mockHolyWeekEventRepository;

  setUp(() {
    mockHolyWeekEventRepository = MockHolyWeekEventRepository();
    useCase = UpdateHolyWeekEventUseCase(mockHolyWeekEventRepository);
  });

  group("UpdateHolyWeekEventUseCase", () {
    test("should return the holy week event updated when the call to the repository is successful", () async {
      //GIVEN
      final HolyWeekEvent holyWeekEventUpdated = InfoObjectMother.createHolyWeekEvent2();

      when(mockHolyWeekEventRepository.updateHolyWeekEvent(holyWeekEventUpdated)).thenAnswer((_) async => holyWeekEventUpdated);

      //WHEN
      await useCase.execute(holyWeekEventUpdated);

      //THEN
      verify(mockHolyWeekEventRepository.updateHolyWeekEvent(holyWeekEventUpdated)).called(1);      
    });

    test('should throw an exception when the call to the repository fails', () async {
      // GIVEN
      final HolyWeekEvent holyWeekEventUpdated = InfoObjectMother.createHolyWeekEvent2();

      when(mockHolyWeekEventRepository.updateHolyWeekEvent(holyWeekEventUpdated)).thenThrow(Exception('Error'));

      // WHEN & THEN
      expect(() => useCase.execute(holyWeekEventUpdated), throwsException);
      verify(mockHolyWeekEventRepository.updateHolyWeekEvent(holyWeekEventUpdated)).called(1);
      verifyNoMoreInteractions(mockHolyWeekEventRepository);
    });
  });
}
