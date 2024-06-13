import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier() : super(const UserState(user: null, isAdmin: false, instrument: "-", phoneNumber: ""));

  void signIn(User? user, bool isAdmin, String instrument, String phoneNumber){
    state = state.copyWith(
      user: user,
      isAdmin: isAdmin,
      instrument: instrument,
      phoneNumber: phoneNumber
    );
  }
  

  void updatePhoneNumber (String phoneNumber) async {
    state = state.copyWith(
      user: state.user,
      isAdmin: state.isAdmin,
      instrument: state.instrument,
      phoneNumber: phoneNumber
    );
  }
}

class UserState extends Equatable{

  final User? user;
  final bool isAdmin;
  final String instrument;
  final String phoneNumber;

  const UserState({
    required this.user,
    this.instrument = "-",
    this.isAdmin = false,
    this.phoneNumber = ""
  });

  copyWith({
    required User? user,
    required bool isAdmin,
    required String instrument,
    required String phoneNumber
  }) => UserState(    
    user: user,
    isAdmin: isAdmin,
    instrument: instrument,
    phoneNumber: phoneNumber
  );
  
  @override
  List<Object?> get props => [user, isAdmin, instrument, phoneNumber]; 
}