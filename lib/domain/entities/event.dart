
import 'package:director_app_tfg/domain/entities/enums/event_type_enum.dart';
import 'package:director_app_tfg/domain/entities/user.dart';
import 'package:uuid/uuid.dart';

class Event {
  final String id;
  final EventTypeEnum type;
  final DateTime date;
  final String location;
  final List<String>? repetoire;
  final Duration? duration;
  final List<User>? attendance;
  final String? moreInformation;

  Event({
    required this.id, 
    required this.type,
    required this.date,
    required this.location,
    this.repetoire,
    this.duration,
    this.attendance,
    this.moreInformation
  });

  factory Event.create({
    required EventTypeEnum type,
    required DateTime date,
    required String location,
    List<String>? repetoire,
    Duration? duration,
    List<User>? attendance,
    String? moreInformation
  }) {
    final uuid = const Uuid().v4();
    return Event(
      id: uuid,
      type: type,
      date: date, 
      location: location,
      repetoire: repetoire,
      duration: duration,
      attendance: attendance,
      moreInformation: moreInformation
    );
  }
}

