class Musician {
  final String email;
  final String name;
  final String phoneNumber;
  final String instrument;
  final bool isAllowed;
  final bool isAdmin;
  final String fcm;

  Musician({
    required this.email,
    required this.name,
    this.phoneNumber = "",
    this.instrument = "",
    required this.isAllowed,
    required this.isAdmin,
    this.fcm = ""
  });

  factory Musician.create({
    required String email,
    required String name,
    String phoneNumber = "",
    String instrument = "",
    required bool isAllowed,
    required bool isAdmin,
    String fcm = ""
  }) {
    return Musician(
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      instrument: instrument,
      isAllowed: isAllowed,
      isAdmin: isAdmin,
      fcm: fcm
    );
  }
}
