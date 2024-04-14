import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier() : super(const UserState(user: null, isAdmin: false, instrument: "-"));

  void signIn(User? user, bool isAdmin, String instrument){
    state = state.copyWith(
      user: user,
      isAdmin: isAdmin,
      instrument: instrument
    );
  }
}

class UserState extends Equatable{

  final User? user;
  final bool isAdmin;
  final String instrument;

  const UserState({
    required this.user,
    this.instrument = "-",
    this.isAdmin = false
  });

  copyWith({
    required User? user,
    required bool isAdmin,
    required String instrument
  }) => UserState(    
    user: user,
    isAdmin: isAdmin,
    instrument: instrument
  );
  
  @override
  List<Object?> get props => [user, isAdmin, instrument]; 
}