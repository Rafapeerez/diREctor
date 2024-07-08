import 'package:director_app_tfg/domain/usecases/event/delete_event_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

import 'event_repository_test.mocks.dart';

void main() {
  late DeleteEventUseCase useCase;
  late MockEventRepository mockEventRepository;

  setUp(() {
    mockEventRepository = MockEventRepository();
    useCase = DeleteEventUseCase(mockEventRepository);
  });

  group("DeleteEventUseCasse", () {
    test("", () => null);
  });
}