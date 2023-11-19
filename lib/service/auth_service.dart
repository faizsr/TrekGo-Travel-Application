import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trekmate_project/helper/helper_functions.dart';
import 'package:trekmate_project/service/database_service.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/alerts_and_navigates.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // ===== User Login =====
  Future loginUserWithEmailandPassword(String email, String password) async {
    try {
      User? user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // ===== User Sign up =====
  Future registerUserWithEmailandPassword(String fullname, String email,
      String password, BuildContext context) async {
    try {
      User? user = (await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      if (user != null) {
        await DatabaseService(uid: user.uid).savingUserData(fullname, email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        debugPrint('Email already in use');
        // ignore: use_build_context_synchronously
        customSnackbar(
            context, 'This email address is already in use', 130, 55, 55);
      }
      debugPrint(e.message);
      return e.message;
    }
  }

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
      // print(e.message);
      return e.message;
    }
  }

  // ===== Signout =====
  Future signOut() async {
    try {
      // ==== USER ====
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserFullName('');
      await HelperFunctions.saveUserEmail('');

      // ==== ADMIN ====
      await HelperFunctions.saveAdminLoggedInStatus(false);
      await HelperFunctions.saveAdminId('');
      await HelperFunctions.saveAdminEmail('');
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
