class MusicianDB {
  final String email;
  final String name;
  final String phoneNumber;
  final String instrument;
  final bool isAllowed;
  final bool isAdmin;
  final String fcm;

  MusicianDB({
    required this.email,
    required this.name,
    this.phoneNumber = "",
    this.instrument = "",
    required this.isAllowed,
    required this.isAdmin,
    required this.fcm
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'instrument': instrument,
      'isAllowed': isAllowed,
      'isAdmin': isAdmin,
      'fcm': fcm
    };
  }

  static MusicianDB fromMap(Map<String, dynamic> map) {
    return MusicianDB(
      email: map['email'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      instrument: map['instrument'],
      isAllowed: map['isAllowed'],
      isAdmin: map['isAdmin'],
      fcm: map['fcm']
    );
  }
}
