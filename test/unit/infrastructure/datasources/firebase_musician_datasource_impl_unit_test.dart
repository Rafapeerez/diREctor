import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:director_app_tfg/infrastructure/datasources/firebase_musician_datasource_impl.dart';
  import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:director_app_tfg/domain/models/musician.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late FirebaseMusicianDatasource datasource;
  late MockFirebaseFirestore mockFirebaseFirestore;

  setUp(() {
    mockFirebaseFirestore = MockFirebaseFirestore();
    datasource = FirebaseMusicianDatasource();
  });

  test('saveMusician should save the musician in Firestore', () async {
    // GIVEN
    final musician = Musician.create(
      email: 'test@example.com',
      name: 'Test Musician',
      isAllowed: true,
      isAdmin: false,
    );
    // when(mockFirebaseFirestore.collection('usuario')).thenReturn(musician);

    // WHEN
    final result = await datasource.saveMusician(musician);

    // THEN
    expect(result, equals(musician));
  });
}