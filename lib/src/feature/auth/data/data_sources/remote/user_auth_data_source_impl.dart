import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trekgo_project/src/feature/auth/data/data_sources/remote/user_auth_data_source.dart';
import 'package:trekgo_project/src/feature/user/data/models/user_model.dart';
import 'package:trekgo_project/src/feature/user/domain/entities/user_entity.dart';

class UserAuthRemoteDataSourceImpl implements UserAuthRemoteDataSource {
  final FirebaseFirestore fireStore;
  final FirebaseAuth auth;

  UserAuthRemoteDataSourceImpl({
    required this.fireStore,
    required this.auth,
  });

  FirebaseFirestore get instance => fireStore;

  @override
  Future<String> login(UserEntity user) async {
    log('Is data: ${user.email} ${user.password}');
    try {
      if (user.email == 'adminlogin@gmail.com') {
        await auth.signInWithEmailAndPassword(
            email: user.email, password: user.password);
        log('Login Success');
        return 'success-admin';
      } else {
        await auth.signInWithEmailAndPassword(
            email: user.email, password: user.password);

        // ======= Checking if user is blocked =======
        final uid = auth.currentUser?.uid;
        final data = await instance.collection('users').doc(uid).get();
        if (data['block'] == true) return 'account-disabled';

        log('Login Success');
        return 'success-user';
      }
    } on FirebaseAuthException catch (e) {
      log('Login Error: ${e.message}');
      return e.code;
    }
  }

  @override
  Future<String> signUp(UserEntity user) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      log('Sign Up Sucess: $result');
      // ========== Creating Collection ==========
      final userCollection = fireStore.collection('users');
      final uid = auth.currentUser?.uid ?? 'newuser';

      userCollection.doc(uid).get().then(
        (userDoc) async {
          final newUser = UserModel(
            id: uid,
            name: user.name,
            email: user.email,
            phoneNumber: user.phoneNumber,
            profilePhoto: user.profilePhoto,
            createdDate: DateTime.now().toString(),
            block: false,
          ).toMap();

          await userCollection.doc(uid).set(newUser);
          log('User Added');
        },
      );
      return 'success';
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  @override
  Future<String> forgotPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return 'success';
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  @override
  Future<void> logout() async {
    await auth.signOut();
  }
}
