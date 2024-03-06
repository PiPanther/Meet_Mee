import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Sign in with Google
  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser != null) {
        final GoogleSignInAuthentication gAuth = await gUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken,
          idToken: gAuth.idToken,
        );
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        return userCredential;
      } else {
        throw FirebaseAuthException(
          code: 'sign_in_canceled',
          message: 'Sign in with Google was canceled by user.',
        );
      }
    } catch (error) {
      throw FirebaseAuthException(
        code: 'google_sign_in_failed',
        message: 'Failed to sign in with Google: $error',
      );
    }
  }

  // Sign in with email and password
  Future<UserCredential> signInWithEmailPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } catch (error) {
      throw FirebaseAuthException(
        code: 'email_sign_in_failed',
        message: 'Failed to sign in with email and password: $error',
      );
    }
  }

  // register via email and password
  Future<UserCredential> registerWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } catch (error) {
      throw FirebaseAuthException(
        code: 'registration_failed',
        message: 'Failed to register user: $error',
      );
    }
  }
}
