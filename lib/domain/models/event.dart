
import 'package:director_app_tfg/domain/models/enums/event_type_enum.dart';
import 'package:director_app_tfg/domain/models/march.dart';
import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:uuid/uuid.dart';

class Event {
  final String id;
  final EventTypeEnum type;
  final DateTime date;
  final String location;
  final List<March> repertoire;
  final Duration duration;
  final List<Musician> attendance;
  final String moreInformation;

  Event({
    required this.id, 
    required this.type,
    required this.date,
    required this.location,
    this.repertoire = const [ ],
    this.duration = Duration.zero,
    this.attendance = const [ ],
    this.moreInformation = " "
  });

  Event.empty()
        : id = "",
          type = EventTypeEnum.concierto,
          date = DateTime.now(),
          location = "",
          repertoire = const [ ],
          duration = Duration.zero,
          attendance = const [ ],
          moreInformation = " ";

  factory Event.create({
    required EventTypeEnum type,
    required DateTime date,
    required String location,
    List<March> repertoire = const [ ],
    Duration duration = Duration.zero,
    List<Musician> attendance = const [ ],
    String moreInformation = " "
  }) {
    final uuid = const Uuid().v4();
    return Event(
      id: uuid,
      type: type,
      date: date, 
      location: location,
      repertoire: repertoire,
      duration: duration,
      attendance: attendance,
      moreInformation: moreInformation
    );
  }
}

