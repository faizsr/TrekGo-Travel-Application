import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trekmate_project/helper/helper_functions.dart';
import 'package:trekmate_project/screens/bottomnav_and_drawer/bottom_navigation_bar.dart';
import 'package:trekmate_project/service/auth_service.dart';
import 'package:trekmate_project/service/database_service.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/alerts_and_navigates.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/custom_alert.dart';

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

    // ignore: use_build_context_synchronously
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

          // ignore: use_build_context_synchronously
          customSnackbar(context, 'Account created successfully', 130, 55, 55);

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

          // ignore: use_build_context_synchronously
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
          await HelperFunctions.saveAdminId(snapshot.docs[0]["admin_id"]);

          // ignore: use_build_context_synchronously
          nextScreenRemoveUntil(
              context,
              NavigationBottomBar(
                isAdmin: true,
                isUser: false,
                userId: FirebaseAuth.instance.currentUser!.uid,
                username: snapshot.docs[0]['fullname'],
                useremail: snapshot.docs[0]['email'],
                usergender: snapshot.docs[0]['gender'],
                usermobile: snapshot.docs[0]['mobile_number'],
                userprofile: snapshot.docs[0]['profilePic'],
              ));
        } else {
          setLoadingCallback(false);
          customSnackbar(context, 'Enter login details correctly', 140, 55, 55);
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

  if ((formKey!.currentState!.validate() && name!.isNotEmpty) &&
      (email!.isNotEmpty ||
          mobile!.isNotEmpty ||
          imageUrl != null ||
          selectedGender != null)) {
    await DatabaseService().userCollection.doc(userId).update({
      'profilePic': imageUrl,
      'email': email,
      'fullname': name.trim().replaceAll(RegExp(r'\s+'), ' '),
      'mobile_number': mobile!.trim(),
      'gender': selectedGender,
    });
    debugPrint('Updated successfully');
    // ignore: use_build_context_synchronously
    customSnackbar(context, 'Updated Successfully', 20, 20, 20);
  } else {
    debugPrint('Update failed');
  }
}
