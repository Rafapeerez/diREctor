import 'package:director_app_tfg/domain/models/enums/event_type_enum.dart';
import 'package:director_app_tfg/domain/models/enums/holy_week_name_enum.dart';
import 'package:director_app_tfg/domain/models/enums/instrumet_type_enum.dart';
import 'package:director_app_tfg/domain/models/event.dart';
import 'package:director_app_tfg/domain/models/holy_week_event.dart';
import 'package:director_app_tfg/domain/models/march.dart';
import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:uuid/uuid.dart';

class InfoObjectMother {

  //EVENT
  static Event createConcert() {
    return Event(
      id: const Uuid().v4(),
      location: "Puente Romano de Cordoba",
      type: EventTypeEnum.concierto,
      date: DateTime(2024, 8, 30, 14, 30, 30),
      repertoire: [],
      duration: const Duration(hours: 2),
      attendance: [],
      moreInformation: "Concert by the Symphony Orchestra"
    );
  }

  static Event createProcesion() {
    return Event(
      id: const Uuid().v4(),
      location: "Puente Romano de Cordoba",
      type: EventTypeEnum.salidaProcesional,
      date: DateTime(2024, 8, 30, 14, 30, 30),
      repertoire: [],
      duration: const Duration(hours: 2),
      attendance: [],
      moreInformation: "Concert by the Symphony Orchestra"
    );
  }

  static Event createConcertWithAttendance(List<String> attendance) {
    return Event(
      id: const Uuid().v4(),
      location: "Puente Romano de Cordoba",
      type: EventTypeEnum.concierto,
      date: DateTime(2024, 8, 30, 14, 30, 30),
      repertoire: [],
      duration: const Duration(hours: 2),
      attendance: attendance,
      moreInformation: "Concert by the Symphony Orchestra"
    );
  }

  static Event createConcertWithRepertoire(List<String> repertoire) {
    return Event(
      id: const Uuid().v4(),
      location: "Puente Romano de Cordoba",
      type: EventTypeEnum.concierto,
      date: DateTime(2024, 8, 30, 14, 30, 30),
      repertoire: repertoire,
      duration: const Duration(hours: 2),
      attendance: [],
      moreInformation: "Concert by the Symphony Orchestra"
    );
  }

  //HOLY WEEK EVENT
  static HolyWeekEvent createHolyWeekEvent(){
    return HolyWeekEvent(
      name: HolyWeekNameEnum.domingoRamos, 
      imageURL: "example//:image", 
      id: const Uuid().v4(), 
      date: DateTime(2024, 8, 30, 14, 30, 30),
      location: "Iglesia de San Francisco",
      duration: const Duration(hours: 2),
      moreInformation: "Example"
    );
  }


  //MARCH
  static March createMarch1(){
    return March(
      id: const Uuid().v4(),
      name: "Perdona a tu pueblo",
      author: "Bernardo Velado Graña y Antonio Alcalde",
      number: 1,
      link: "https://www.youtube.com/watch?v=YiA5tlCS7BE",
      moreInformation: ""
    ); 
  }

  static March createMarch2(){
    return March(
      id: const Uuid().v4(),
      name: "Himno Nacional",
      author: "Manuel Espinosa de los Monteros",
      number: 2,
      link: "https://www.youtube.com/watch?v=4BF20CiOHpg",
      moreInformation: ""
    ); 
  }

  static March createMarch3(){
    return March(
      id: const Uuid().v4(),
      name: "El Pan de vida",
      author: "Juan Manuel Carmona",
      number: 3,
      link: "https://www.youtube.com/watch?v=FOEQgtXT_YE",
      moreInformation: "También tiene los números 7, 16 y 27"
    ); 
  }

  //MUSICIAN
  static Musician createJohnMusicianWithoutPermission() {
    return Musician(
      email: "john@gmail.com", 
      name: "John Smith", 
      isAllowed: false, 
      isAdmin: false,
      fcm: "asdfadbhjcioadosbfhuwioefbeadsnjklvbjiepbcipsasjipe",
      instrument: InstrumentTypeEnum.trumpet.displayName,
      phoneNumber: "+34777777770",
      totalEventsAttendance: 0
    );
  }

  static Musician createMarieMusicianWithPermission() {
    return Musician(
      email: "marie@gmail.com", 
      name: "Marie Smith", 
      isAllowed: true, 
      isAdmin: false,
      fcm: "asdfadbhjcioadosbfhuwioefbeadsnjklvbjiepbcipsasjope",
      instrument: InstrumentTypeEnum.percussion.displayName,
      phoneNumber: "+34777777771",
      totalEventsAttendance: 0
    );
  }

  static Musician createAdmin() {
    return Musician(
      email: "admin@gmail.com", 
      name: "Admin", 
      isAllowed: true, 
      isAdmin: true,
      fcm: "asdfadbhjcioadosbfhuwioefbeadsnjklvbjiepbcipsasjiupe",
      instrument: InstrumentTypeEnum.bass.displayName,
      phoneNumber: "+34777777772",
      totalEventsAttendance: 0
    );
  }
}
