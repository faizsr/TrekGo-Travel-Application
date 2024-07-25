import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // ===== Admin Login =====
  Future loginAdminWithEmailandPassword(String email, String password) async {
    try {
      User? admin = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;

      if (admin != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
