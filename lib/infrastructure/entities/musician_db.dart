import 'package:director_app_tfg/domain/models/musician.dart';

class MusicianDB {
  final String id;
  final String email;
  final String name;
  final String surname;
  final String? phoneNumber;
  final String? instrument;
  final bool isAllowed;
  final bool isAdmin;

  MusicianDB({
    required this.id,
    required this.email,
    required this.name,
    required this.surname,
    this.phoneNumber,
    this.instrument,
    required this.isAllowed,
    required this.isAdmin
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'surname': surname,
      'phoneNumber': phoneNumber,
      'instrument': instrument,
      'isAllowed': isAllowed,
      'isAdmin': isAdmin,
    };
  }
}
