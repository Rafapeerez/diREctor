import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier() : super(
    const UserState(
      user: null, 
      isAdmin: false, 
      instrument: "-", 
      phoneNumber: "",
      fcm: "",
      totalEventsAttendance: 0
    )
  );

  void signIn(User? user, bool isAdmin, String instrument, String phoneNumber, String fcm, int totalEventsAttendance){
    state = state.copyWith(
      user: user,
      isAdmin: isAdmin,
      instrument: instrument,
      phoneNumber: phoneNumber,
      fcm: fcm,
      totalEventsAttendance: totalEventsAttendance
    );
  }

  void updatePhoneNumber (String phoneNumber) async {
    state = state.copyWith(
      user: state.user,
      isAdmin: state.isAdmin,
      instrument: state.instrument,
      phoneNumber: phoneNumber,
      fcm: state.fcm,
      totalEventsAttendance: state.totalEventsAttendance
    );
  }
}

class UserState extends Equatable{

  final User? user;
  final bool isAdmin;
  final String instrument;
  final String phoneNumber;
  final String fcm;
  final int totalEventsAttendance;

  const UserState({
    required this.user,
    this.instrument = "-",
    this.isAdmin = false,
    this.phoneNumber = "",
    required this.fcm,
    required this.totalEventsAttendance
  });

  copyWith({
    required User? user,
    required bool isAdmin,
    required String instrument,
    required String phoneNumber,
    required String fcm,
    required int totalEventsAttendance
  }) => UserState(    
    user: user,
    isAdmin: isAdmin,
    instrument: instrument,
    phoneNumber: phoneNumber,
    fcm: fcm,
    totalEventsAttendance: totalEventsAttendance
  );
  
  @override
  List<Object?> get props => [user, isAdmin, instrument, phoneNumber, fcm, totalEventsAttendance]; 
}