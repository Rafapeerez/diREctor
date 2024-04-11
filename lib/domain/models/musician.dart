class Musician {
  final String email;
  final String name;
  final String surname;
  final String? phoneNumber;
  final String? instrument;
  final bool isAllowed;
  final bool isAdmin;

  Musician({
    required this.email,
    required this.name,
    required this.surname,
    this.phoneNumber,
    this.instrument,
    required this.isAllowed,
    required this.isAdmin
  });

  factory Musician.create({
    required String email,
    required String name,
    required String surname,
    String? phoneNumber,
    String? instrument,
    required bool isAllowed,
    required bool isAdmin
  }) {
    return Musician(
      name: name,
      email: email,
      surname: surname,
      phoneNumber: phoneNumber,
      instrument: instrument,
      isAllowed: isAllowed,
      isAdmin: isAdmin
    );
  }

}
