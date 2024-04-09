import 'package:uuid/uuid.dart';

class Musician {
  final String id;
  final String email;
  final String name;
  final String surname;
  final String? phoneNumber;
  final String? instrument;
  final DateTime? birthdate;
  final bool isAllowed;
  final bool isAdmin;

  Musician(
      {required this.id,
      required this.email,
      required this.name,
      required this.surname,
      this.phoneNumber,
      this.instrument,
      this.birthdate,
      required this.isAllowed,
      required this.isAdmin});

  factory Musician.create(
      {required String email,
      required String name,
      required String surname,
      String? phoneNumber,
      String? instrument,
      DateTime? birthdate,
      required bool isAllowed,
      required bool isAdmin}) {
    final uuid = const Uuid().v4();
    return Musician(
        id: uuid,
        name: name,
        email: email,
        surname: surname,
        phoneNumber: phoneNumber,
        instrument: instrument,
        birthdate: birthdate,
        isAllowed: isAllowed,
        isAdmin: isAdmin);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'surname': surname,
      'phoneNumber': phoneNumber,
      'instrument': instrument,
      'birthdate': birthdate?.toIso8601String(),
      'isAllowed': isAllowed,
      'isAdmin': isAdmin,
    };
  }

  @override
  String toString() {
    return name;
  }
}
