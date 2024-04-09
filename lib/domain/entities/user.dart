import 'package:uuid/uuid.dart';

class User {
  final String id;
  final String email;
  final String name;
  final String surname;
  final String? phoneNumber;
  final String instrument;
  final DateTime? birthdate;
  final bool isAllowed;
  final bool isAdmin;

  User({
    required this.id, 
    required this.email,
    required this.name,
    required this.surname,
    this.phoneNumber,
    required this.instrument,
    this.birthdate,
    required this.isAllowed,
    required this.isAdmin
  });

  factory User.create({
    required String email,
    required String name,
    required String surname,
    String? phoneNumber,
    required String instrument,
    DateTime? birthdate,
    required bool isAllowed,
    required bool isAdmin
  }) {
    final uuid = const Uuid().v4();
    return User(
      id: uuid,
      name: name,
      email: email, 
      surname: surname,
      phoneNumber: phoneNumber,
      instrument: instrument,
      birthdate: birthdate,
      isAllowed: isAllowed,
      isAdmin: isAdmin
    );
  }
}
