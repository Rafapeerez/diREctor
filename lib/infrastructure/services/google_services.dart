import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleServices {
  static final FirebaseAuth _authInstance = FirebaseAuth.instance;

  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static User? user;

  // Sign In with Google
  Future<User?> signInWithGoogle() async {
    GoogleSignInAccount? googleSingInAccount = await _googleSignIn.signIn();

    if (googleSingInAccount != null) {
      GoogleSignInAuthentication googleSignInAuthentication = await googleSingInAccount.authentication;
      
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken
      );

      UserCredential userCredential = await _authInstance.signInWithCredential(credential);
      user = userCredential.user;

      return user;
    }

    return user;
  }

  static Future<void> signOut() async{
    _authInstance.signOut();
    _googleSignIn.signOut();
  }
}
