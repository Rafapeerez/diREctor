import 'dart:typed_data';

import 'package:director_app_tfg/domain/models/holy_week_event.dart';
import 'package:director_app_tfg/aplication/usecases/holy_week_event/upload_image_to_storage_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mother/info_object_mother.dart';
import 'holy_week_event_repository_test.mocks.dart';

void main() {
  late UploadImageToStorage useCase;
  late MockHolyWeekEventRepository mockHolyWeekEventRepository;

  setUp(() {
    mockHolyWeekEventRepository = MockHolyWeekEventRepository();
    useCase = UploadImageToStorage(mockHolyWeekEventRepository);
  });

  group("UploadImageToStorageUseCase", () {
    test("should return the image URL when the call to the repository is successful", () async {
      //GIVEN
      final HolyWeekEvent holyWeekEvent = InfoObjectMother.createHolyWeekEvent1();
      final Uint8List file = Uint8List.fromList([
        0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 
      ]);
      String imageUrl = "https://firebasestorage.googleapis.com/v0/b/director-2024-redencion.appspot.com/o/Descanso.png?alt=media&token=2fbb86b3-b765-4c31-b938-b2c45025cc7a";

      when(mockHolyWeekEventRepository.uploadImageToStorage(file, holyWeekEvent.id)).thenAnswer((_) async => imageUrl);

      //WHEN
      final result = await useCase.execute(file, holyWeekEvent.id);

      //THEN
      verify(mockHolyWeekEventRepository.uploadImageToStorage(file, holyWeekEvent.id)).called(1);
      expect(result, imageUrl);
    });

    test('should throw an exception when the call to the repository fails', () async {
      // GIVEN
      final HolyWeekEvent holyWeekEvent = InfoObjectMother.createHolyWeekEvent1();
      final Uint8List file = Uint8List.fromList([
        0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 
      ]);

      when(mockHolyWeekEventRepository.uploadImageToStorage(file, holyWeekEvent.id)).thenThrow(Exception('Error'));

      // WHEN & THEN
      expect(() => useCase.execute(file, holyWeekEvent.id), throwsException);
      verify(mockHolyWeekEventRepository.uploadImageToStorage(file, holyWeekEvent.id)).called(1);
      verifyNoMoreInteractions(mockHolyWeekEventRepository);
    });
  });
}
