import 'package:director_app_tfg/domain/models/enums/event_type_enum.dart';
import 'package:director_app_tfg/domain/models/enums/holy_week_name_enum.dart';
import 'package:director_app_tfg/domain/models/event.dart';
import 'package:uuid/uuid.dart';

class HolyWeekEvent extends Event {
  final HolyWeekNameEnum name;
  final String imageURL;

  HolyWeekEvent({
    required this.name,
    required this.imageURL,
    required super.id, 
    super.type = EventTypeEnum.salidaProcesional, 
    required super.date, 
    required super.location,
    super.duration = Duration.zero,
    super.moreInformation = ""
  });

  HolyWeekEvent.empty()
    : name = HolyWeekNameEnum.juevesPasion,
    imageURL = "",
      super(
        id: "",
        type: EventTypeEnum.salidaProcesional,
        date: DateTime.now(),
        location: "",
      );

  factory HolyWeekEvent.create({
    required HolyWeekNameEnum name,
    required String image,
    required DateTime date,
    required String location,
    Duration duration = Duration.zero,
    String moreInformation = ""
  }) {
    final uuid = const Uuid().v4();
    return HolyWeekEvent(
      id: uuid,
      name: name,
      imageURL: image,
      date: date, 
      location: location,
      duration: duration,
      moreInformation: moreInformation
    );
  }

  factory HolyWeekEvent.update({
    required String id,
    required HolyWeekNameEnum name,
    required String image,
    required DateTime date,
    required String location,
    required Duration duration,
    required String moreInformation 
  }) {
    return HolyWeekEvent(
      id: id,
      name: name,
      imageURL: image,
      date: date, 
      location: location,
      duration: duration,
      moreInformation: moreInformation
    );
  }
}
