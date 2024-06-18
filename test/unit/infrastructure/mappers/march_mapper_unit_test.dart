import 'package:director_app_tfg/domain/models/march.dart';
import 'package:director_app_tfg/infrastructure/mappers/march_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mother/info_object_mother.dart';

void main() {
  test("should convert a march from domain to db", () {
    //GIVEN
    March march = InfoObjectMother.createMarch1();

    //WHEN
    March mappedMarch = MarchMapper.marchToDomain(MarchMapper.marchToEntity(march));

    //THEN
    expect(march.id, mappedMarch.id);
    expect(march.name, mappedMarch.name);
    expect(march.author, mappedMarch.author);
    expect(march.number, mappedMarch.number);
    expect(march.link, mappedMarch.link);
    expect(march.moreInformation, mappedMarch.moreInformation);
  });
}
