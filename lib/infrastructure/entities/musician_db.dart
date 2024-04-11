class MusicianDB {
  final String email;
  final String name;
  final String surname;
  final String? phoneNumber;
  final String? instrument;
  final bool isAllowed;
  final bool isAdmin;

  MusicianDB({
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
      'name': name,
      'email': email,
      'surname': surname,
      'phoneNumber': phoneNumber,
      'instrument': instrument,
      'isAllowed': isAllowed,
      'isAdmin': isAdmin,
    };
  }

  static MusicianDB fromMap(Map<String, dynamic> map) {
    return MusicianDB(
      email: map['email'],
      name: map['name'],
      surname: map['surname'],
      phoneNumber: map['phoneNumber'],
      instrument: map['instrument'],
      isAllowed: map['isAllowed'],
      isAdmin: map['isAdmin'],
    );
  }
}
