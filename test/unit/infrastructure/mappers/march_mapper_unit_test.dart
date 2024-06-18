import 'package:director_app_tfg/domain/models/march.dart';
import 'package:director_app_tfg/infrastructure/entities/march_db.dart';
import 'package:director_app_tfg/infrastructure/mappers/march_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

void main() {
  
  test("should convert a march from db to domain", (){

    //GIVEN      
    March march = March.create(
      name: "Perdona a tu pueblo",
      author: "Bernardo Velado Graña y Antonio Alcalde",
      number: 1,
      link: "https://www.youtube.com/watch?v=YiA5tlCS7BE",
      moreInformation: "prueba"
    ); 
    
    //WHEN
    March mappedMarch = MarchMapper.marchToDomain(MarchMapper.marchToEntity(march));

    //THEN
    expect(march.id,                mappedMarch.id);
    expect(march.name,              mappedMarch.name);
    expect(march.author,              mappedMarch.author);
    expect(march.number,          mappedMarch.number);
    expect(march.link,          mappedMarch.link);
    expect(march.moreInformation, mappedMarch.moreInformation);
  
  });

  test("should convert an march from domain to db", (){

    //GIVEN
    MarchDB entity = MarchDB(
      id: const Uuid().v4(),
      name: "Perdona a tu pueblo",
      author: "Bernardo Velado Graña y Antonio Alcalde",
      number: 1,
      link: "https://www.youtube.com/watch?v=YiA5tlCS7BE",
      moreInformation: "prueba"
    );

    //WHEN
    March mappedDomain = MarchMapper.marchToDomain(entity);
    MarchDB mappedEntity = MarchMapper.marchToEntity(mappedDomain);

    //THEN
  
    expect(entity.id,                 mappedEntity.id);
    expect(entity.name,               mappedEntity.name);
    expect(entity.author,               mappedEntity.author);
    expect(entity.number,           mappedEntity.number);
    expect(entity.link,           mappedEntity.link);
    expect(entity.moreInformation,    mappedEntity.moreInformation);
  
  });
}
