// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trekgo_project/service/database_service.dart';
import 'package:trekgo_project/widgets/reusable_widgets/alerts_and_navigates.dart';

// ==================== Adding new place function ====================
addNewDestination({
  GlobalKey<FormState>? formKey,
  XFile? selectedImage,
  double? ratingCount,
  Function(bool)? setLoadingCallback,
  String? imageUrl,
  String? selectedCategory,
  String? selectedState,
  String? title,
  String? description,
  String? location,
  String? mapLink,
  BuildContext? context,
}) async {
  if (selectedCategory == null) {
    customSnackbar(context, 'Please select a category', 20, 20, 20);
  }
  if (selectedState == null) {
    customSnackbar(context, 'Please select a state', 20, 20, 20);
  }
  if (selectedImage == null) {
    customSnackbar(context, 'Please select a image', 20, 20, 20);
  }

  if (formKey!.currentState!.validate() &&
      selectedCategory != null &&
      selectedState != null &&
      selectedImage != null &&
      ratingCount != null) {
    setLoadingCallback!(true);
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    try {
      await referenceImageToUpload.putFile(File(selectedImage.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setLoadingCallback(false);
    }

    debugPrint(uniqueFileName);
    DatabaseService().savingDestination(
      selectedCategory,
      selectedState,
      imageUrl!,
      title!.trim(),
      description!.trim(),
      location!.trim(),
      mapLink ?? '',
      ratingCount,
    );
    debugPrint(selectedCategory);
    debugPrint(selectedState);
    debugPrint('Data successfully added');
    customSnackbar(context, 'New Destination Created', 20, 20, 20);
    Navigator.of(context!).pop();

    // nextScreen(
    //   context,
    //   NavigationBottomBar(
    //     isAdmin: true,
    //     isUser: false,
    //     userId: FirebaseAuth.instance.currentUser!.uid,
    //   ),
    // );
  } else {
    debugPrint('New place not added');
    setLoadingCallback!(false);
    // customSnackbar(context, 'Please fill all forms', 20, 20, 20);
  }
}

// ==================== Function for updating the detials ====================
updateDestinationn({
  String? placeImage,
  XFile? selectedImage,
  String? imageUrl,
  String? title,
  String? description,
  String? location,
  String? mapLink,
  double? ratingCount,
  String? initialCategory,
  String? selectedCategory,
  String? initialState,
  String? selectedState,
  String? placeId,
  Function(bool)? setLoadingCallback,
  BuildContext? context,
  GlobalKey<FormState>? formkey,
}) async {
  Reference referenceImageToUpload =
      FirebaseStorage.instance.refFromURL(placeImage!);

  try {
    await referenceImageToUpload.putFile(File(selectedImage!.path));
    imageUrl = await referenceImageToUpload.getDownloadURL();
  } catch (e) {
    debugPrint(e.toString());
  }
  if (selectedCategory == null) {
    customSnackbar(context, 'Please select a category', 20, 20, 20);
  }
  if (selectedState == null) {
    customSnackbar(context, 'Please select a state', 20, 20, 20);
  }

  // ===== Saving to the database =====
  if (formkey!.currentState!.validate() &&
      ratingCount != null &&
      imageUrl != null) {
    setLoadingCallback!(true);

    await DatabaseService().destinationCollection.doc(placeId).update({
      'image': imageUrl,
      'name': title?.trim(),
      'description': description?.trim(),
      'location': location?.trim(),
      'rating': ratingCount,
      'category': selectedCategory,
      'state': selectedState,
      'map': mapLink,
    });
    debugPrint('map link $mapLink');
    debugPrint('Updated');
    customSnackbar(context, 'Updated successfully', 20, 20, 20);
    Navigator.of(context!).pop();
  } else {
    debugPrint('Not updated');
    setLoadingCallback!(false);
  }
}
