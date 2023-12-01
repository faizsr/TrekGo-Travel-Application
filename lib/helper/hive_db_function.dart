import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trekmate_project/model/wishlist.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/alerts_and_navigates.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/custom_alert.dart';

// ==================== Add new wishlist ====================

addWishlist({
  GlobalKey<FormState>? formKey,
  XFile? selectedImage,
  String? selectedState,
  int? intHiveKey,
  String? hiveKey,
  String? userId,
  String? name,
  String? descripition,
  String? location,
  Box<Wishlist>? wishlistBox,
  Function(bool)? setLoadingCallback,
  BuildContext? context,
}) {
  if (formKey!.currentState!.validate() &&
      selectedImage != null &&
      selectedState != null) {
    setLoadingCallback!(true);
    intHiveKey = DateTime.now().millisecondsSinceEpoch;
    // formKey.currentState?.save();
    hiveKey = intHiveKey.toString();
    debugPrint('Added at hive key: $hiveKey');
    debugPrint('Added in the user id $userId');
    wishlistBox!.put(
        hiveKey,
        Wishlist(
          hiveKey: hiveKey,
          userId: userId,
          state: selectedState,
          name: name,
          image: selectedImage.path,
          description: descripition,
          location: location,
        ));
    // customSnackbar(context, 'New wishlist created!', 0, 20, 20);
    debugPrint('Data added');
  } else {
    setLoadingCallback!(false);
    customSnackbar(context, 'Fill all forms!', 0, 20, 20);
    debugPrint('Details not updated');
  }
  setLoadingCallback(true);
  debugPrint(selectedState);
}

// ==================== Update wishlist ====================

updateWishlist({
  String? name,
  String? description,
  String? location,
  String? image,
  String? initialState,
  String? imageUrl,
  String? userId,
  String? hiveKey,
  XFile? selectedImage,
  String? selectedState,
  Box<Wishlist>? wishlistBox,
}) {
  if (name!.isNotEmpty &&
      description!.isNotEmpty &&
      location!.isNotEmpty &&
      initialState != null &&
      imageUrl != null) {
    wishlistBox!.put(
        hiveKey ?? '',
        Wishlist(
          userId: userId,
          hiveKey: hiveKey,
          image: selectedImage?.path ?? image,
          state: selectedState ?? initialState,
          name: name,
          description: description,
          location: location,
        ));
    debugPrint('Updated at hive key $hiveKey');
  }
}

// ==================== Delete wishlist ====================

deleteWishlist(
    BuildContext context, Box<Wishlist> wishlistBox, String hiveKey) {
  showDialog(
    context: context,
    builder: (context) {
      return CustomAlertDialog(
        title: 'Delete Wishlist?',
        description: 'This place will be permanently deleted from this list',
        onTap: () async {
          await wishlistBox.delete(hiveKey);
          debugPrint('Deleted successfully at index $hiveKey');
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop('refresh');

          // ignore: use_build_context_synchronously
          Navigator.of(context).pop('refresh');
          // ignore: use_build_context_synchronously
          customSnackbar(context, 'Deleted succesfully', 0, 20, 20);
          // wishListNotifier.value = wishlistBox.values.toList();
          // wishListNotifier.notifyListeners();
        },
      );
    },
  );
}
