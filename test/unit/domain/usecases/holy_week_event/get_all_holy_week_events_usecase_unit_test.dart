import 'package:director_app_tfg/domain/models/holy_week_event.dart';
import 'package:director_app_tfg/domain/usecases/holy_week_event/get_all_holy_week_events_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mother/info_object_mother.dart';
import 'holy_week_event_repository_test.mocks.dart';

void main() {
  late GetAllHolyWeekEventsOrderByDateUseCase useCase;
  late MockHolyWeekEventRepository mockHolyWeekEventRepository;

  setUp(() {
    mockHolyWeekEventRepository = MockHolyWeekEventRepository();
    useCase = GetAllHolyWeekEventsOrderByDateUseCase(mockHolyWeekEventRepository);
  });

  group("GetAllHolyWeekEventsOrderByDateUseCase", () {
    test("should return a list of holy week events order by date when the call to the repository is successful", () async {
      //GIVEN
      final List<HolyWeekEvent> holyWeekEventList = [
        InfoObjectMother.createHolyWeekEvent2(),
        InfoObjectMother.createHolyWeekEvent1(),
      ];
      
      final List<HolyWeekEvent> expectedList = List.from(holyWeekEventList)..sort((a, b) => a.date.compareTo(b.date));

      final stream = Stream<List<HolyWeekEvent>>.fromIterable([holyWeekEventList]);
      when(mockHolyWeekEventRepository.getAllHolyWeekEvents()).thenAnswer((_) => stream);

      //WHEN
      final result = await useCase.execute().first;

      //THEN
      verify(mockHolyWeekEventRepository.getAllHolyWeekEvents()).called(1);
      expect(result, equals(expectedList));
      expect(result.first.name, equals(holyWeekEventList[0].name));
    });

    test('should throw an exception when the call to the repository fails', () async {
      // GIVEN
      when(mockHolyWeekEventRepository.getAllHolyWeekEvents()).thenThrow(Exception('Error'));

      // WHEN & THEN
      expect(() => useCase.execute(), throwsException);
      verify(mockHolyWeekEventRepository.getAllHolyWeekEvents()).called(1);
      verifyNoMoreInteractions(mockHolyWeekEventRepository);
    });
  });
}
