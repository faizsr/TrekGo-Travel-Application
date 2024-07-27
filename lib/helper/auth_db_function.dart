// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trekgo_project/helper/helper_functions.dart';
import 'package:trekgo_project/widgets/bottomnav_and_drawer/bottom_navigation_bar.dart';
import 'package:trekgo_project/service/auth_service.dart';
import 'package:trekgo_project/service/database_service.dart';
import 'package:trekgo_project/widgets/reusable_widgets/alerts_and_navigates.dart';

// ==================== User Sign Up function ====================
userSignUp({
  GlobalKey<FormState>? formKey,
  AuthService? authService,
  String? fullName,
  String? email,
  String? password,
  bool? isLoading,
  Function(bool)? setLoadingCallback,
  BuildContext? context,
}) async {
  if (formKey!.currentState!.validate()) {
    setLoadingCallback!(true);

    await authService!
        .registerUserWithEmailandPassword(
      fullname: fullName!.trim(),
      email: email!.trim(),
      password: password!.trim(),
      gender: 'Male',
      mobileNumber: '',
      profilePic: '',
      context: context!,
    )
        .then(
      (value) async {
        if (value == true && email != 'adminlogin@gmail.com') {
          debugPrint('Account created');

          customSnackbar(context, 'Account created successfully', 20, 20, 20);

          setLoadingCallback(false);
        } else {
          setLoadingCallback(false);
          debugPrint('Account not created');
        }
      },
    );
  }
}

// ==================== User login function ====================
userLoginFunction({
  GlobalKey<FormState>? formKey,
  AuthService? authService,
  String? email,
  String? password,
  bool? isLoading,
  Function(bool)? setLoadingCallback,
  BuildContext? context,
}) async {
  if (formKey!.currentState!.validate() && password!.length > 5) {
    setLoadingCallback!(true);
    await authService!
        .loginUserWithEmailandPassword(email ?? '', password)
        .then(
      (value) async {
        if (value == true && email != 'adminlogin@gmail.com') {
          debugPrint('login succesfully');
          QuerySnapshot snapshot =
              await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .gettingUserData(email ?? '');

          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserFullName(snapshot.docs[0]["fullname"]);
          await HelperFunctions.saveUserEmail(email ?? '');

          nextScreenRemoveUntil(
              context,
              NavigationBottomBar(
                isAdmin: false,
                isUser: true,
                userId: FirebaseAuth.instance.currentUser!.uid,
                username: snapshot.docs[0]['fullname'],
                useremail: snapshot.docs[0]['email'],
                usergender: snapshot.docs[0]['gender'],
                usermobile: snapshot.docs[0]['mobile_number'],
                userprofile: snapshot.docs[0]['profilePic'],
              ));
        } else {
          setLoadingCallback(false);

          showDialog(
            context: context!,
            builder: (context) {
              return const CustomAlertDialog(
                title: 'Incorrect Login Details',
                description:
                    'The email and password you entered is incorrect. Please try again.',
                disableActionBtn: true,
                popBtnText: 'OK',
              );
            },
          );
          debugPrint('Error login in');
        }
      },
    );
  }
}

// ==================== Admin login function ====================
adminLogin({
  GlobalKey<FormState>? formKey,
  AuthService? authService,
  String? email,
  String? password,
  Function(bool)? setLoadingCallback,
  BuildContext? context,
}) async {
  if (formKey!.currentState!.validate() && password!.length > 5) {
    setLoadingCallback!(true);
    await authService!
        .loginAdminWithEmailandPassword(email ?? ' ', password)
        .then(
      (value) async {
        if (value == true && email == 'adminlogin@gmail.com') {
          QuerySnapshot snapshot =
              await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .gettingAdminData(email ?? '');

          // saving the values to our shared preferences
          await HelperFunctions.saveAdminLoggedInStatus(true);
          await HelperFunctions.saveAdminEmail(email ?? '');
          await HelperFunctions.saveAdminId('admin');

          nextScreenRemoveUntil(
              context,
              NavigationBottomBar(
                isAdmin: true,
                isUser: false,
                userId: FirebaseAuth.instance.currentUser!.uid,
                username: snapshot.docs[0]['fullname'] ?? '',
                useremail: snapshot.docs[0]['email'] ?? '',
                usergender: snapshot.docs[0]['gender'] ?? '',
                usermobile: snapshot.docs[0]['mobile_number'] ?? '',
                userprofile: snapshot.docs[0]['profilePic'] ?? '',
              ));
        } else {
          setLoadingCallback(false);
          customSnackbar(context, 'Enter login details correctly', 20, 29, 20);
          debugPrint('Enter admin id correctly');
          debugPrint('$context');
        }
      },
    );
  }
}

// ==================== Update user detials function ====================
updateUserDetailss({
  XFile? selectedImage,
  String? userId,
  String? imageUrl,
  String? name,
  String? email,
  String? mobile,
  String? image,
  String? selectedGender,
  BuildContext? context,
  GlobalKey<FormState>? formKey,
  bool? isLoading,
  Function(bool)? setLoadingCallback,
  double? snackBarBtmPadding,
}) async {
  try {
    if (selectedImage != null) {
      Reference referenceImageToUpload =
          FirebaseStorage.instance.ref().child(userId ?? '');
      await referenceImageToUpload.putFile(File(selectedImage.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } else {
      imageUrl = image;
    }
  } catch (e) {
    debugPrint(e.toString());
  }

  if (formKey!.currentState!.validate()) {
    setLoadingCallback!(true);
    await DatabaseService().userCollection.doc(userId).update({
      'profilePic': imageUrl,
      'email': email,
      'fullname': name?.trim().replaceAll(RegExp(r'\s+'), ' '),
      'mobile_number': mobile?.trim(),
      'gender': selectedGender,
    });
    debugPrint('Updated successfully');
    customSnackbar(
        context, 'Updated Successfully', snackBarBtmPadding ?? 0, 20, 20);
    // setLoadingCallback!(true);
    Navigator.of(context!).pop();
  } else {
    debugPrint('Update failed');
    setLoadingCallback!(false);
    // setLoadingCallback!(false);
  }
}
