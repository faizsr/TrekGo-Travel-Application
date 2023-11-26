import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trekmate_project/screens/bottom_page_navigator/bottom_navigation_bar.dart';
import 'package:trekmate_project/service/database_service.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/alerts_and_navigates.dart';

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
  if (formKey!.currentState!.validate() &&
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
      selectedCategory!,
      selectedState!,
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

    // ignore: use_build_context_synchronously
    nextScreen(
      context,
      NavigationBottomBar(
        isAdmin: true,
        isUser: false,
        userId: FirebaseAuth.instance.currentUser!.uid,
      ),
    );
  } else {
    customSnackbar(context, 'Please fill all forms', 20, 20, 20);
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
  double? ratingCount,
  String? initialCategory,
  String? selectedCategory,
  String? initialState,
  String? selectedState,
  String? placeId,
  Function(bool)? setLoadingCallback,
  BuildContext? context,
}) async {
  Reference referenceImageToUpload =
      FirebaseStorage.instance.refFromURL(placeImage!);

  try {
    await referenceImageToUpload.putFile(File(selectedImage!.path));
    imageUrl = await referenceImageToUpload.getDownloadURL();
  } catch (e) {
    debugPrint(e.toString());
  }

  // ===== Saving to the database =====
  if (title!.isNotEmpty &&
      description!.isNotEmpty &&
      location!.isNotEmpty &&
      ratingCount != null &&
      imageUrl != null &&
      initialCategory != null &&
      initialState != null) {
    setLoadingCallback!(true);

    await DatabaseService().destinationCollection.doc(placeId).update({
      'place_image': imageUrl,
      'place_name': title.trim(),
      'place_description': description.trim(),
      'place_location': location.trim(),
      'place_rating': ratingCount,
      'place_category': selectedCategory,
      'place_state': selectedState,
    });
    debugPrint('Updated');
    // ignore: use_build_context_synchronously
    customSnackbar(context, 'Updated successfully', 20, 20, 20);
  } else {
    debugPrint('Not updated');
  }
  setLoadingCallback!(false);
}
