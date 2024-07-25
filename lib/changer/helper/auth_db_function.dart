// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/alerts_and_navigates.dart';

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
    // await DatabaseService().userCollection.doc(userId).update({
    //   'profilePic': imageUrl,
    //   'email': email,
    //   'fullname': name?.trim().replaceAll(RegExp(r'\s+'), ' '),
    //   'mobile_number': mobile?.trim(),
    //   'gender': selectedGender,
    // });
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
