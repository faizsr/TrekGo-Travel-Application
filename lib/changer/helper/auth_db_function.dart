// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trekgo_project/changer/helper/helper_functions.dart';
import 'package:trekgo_project/changer/service/auth_service.dart';
import 'package:trekgo_project/changer/service/database_service.dart';
import 'package:trekgo_project/src/feature/auth/presentation/views/main_page.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/alerts_and_navigates.dart';

// ==================== User Sign Up function ====================

// ==================== User login function ====================

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

          nextScreenRemoveUntil(context, const MainPage());
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
