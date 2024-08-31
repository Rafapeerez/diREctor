import 'package:director_app_tfg/domain/usecases/march/delete_march_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

import 'march_repository_test.mocks.dart';

void main() {
  late DeleteMarchUseCase useCase;
  late MockMarchRepository mockEventRepository;

  setUp(() {
    mockEventRepository = MockMarchRepository();
    useCase = DeleteMarchUseCase(mockEventRepository);
  });

  group("DeleteMarchUseCase", () {
    test("", () => null);
  });
}