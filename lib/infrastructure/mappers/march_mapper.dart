import 'package:director_app_tfg/domain/models/march.dart';
import 'package:director_app_tfg/infrastructure/entities/march_db.dart';

class MarchMapper {
  static March marchToDomain(MarchDB marchDB) {
    return March(
      id: marchDB.id,
      name: marchDB.name, 
      author: marchDB.author,
      number: marchDB.number,
      link: marchDB.link,
      moreInformation: marchDB.moreInformation
    );
  }

  static MarchDB marchToEntity(March march) {
    return MarchDB(
      id: march.id, 
      name: march.name, 
      author: march.author,
      number: march.number,
      link: march.link,
      moreInformation: march.moreInformation
    );
  }
}
