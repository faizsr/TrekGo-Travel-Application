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
  if (selectedImage == null) {
    customSnackbar(context, 'Please choose a image', 0, 20, 20);
  }

  if (formKey!.currentState!.validate() &&
      selectedImage != null &&
      selectedState != null) {
    setLoadingCallback!(true);
    intHiveKey = DateTime.now().millisecondsSinceEpoch;
    hiveKey = intHiveKey.toString();
    debugPrint('Added at hive key: $hiveKey');
    debugPrint('Added in the user id $userId');
    wishlistBox!.put(
        hiveKey,
        Wishlist(
          hiveKey: hiveKey,
          userId: userId,
          state: selectedState,
          name: name?.trim().replaceAll(RegExp(r'\s+'), ' '),
          image: selectedImage.path,
          description: descripition?.trim().replaceAll(RegExp(r'\s+'), ' '),
          location: location?.trim().replaceAll(RegExp(r'\s+'), ' '),
        ));
    customSnackbar(context, 'New wishlist created!', 0, 20, 20);
    debugPrint('Data added');
  } else {
    setLoadingCallback!(false);
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
  GlobalKey<FormState>? formkey,
  Box<Wishlist>? wishlistBox,
  BuildContext? context,
}) {
  if (formkey!.currentState!.validate() && imageUrl != null) {
    wishlistBox!.put(
        hiveKey ?? '',
        Wishlist(
          userId: userId,
          hiveKey: hiveKey,
          image: selectedImage?.path ?? image,
          state: selectedState ?? initialState,
          name: name?.trim().replaceAll(RegExp(r'\s+'), ' '),
          description: description?.trim().replaceAll(RegExp(r'\s+'), ' '),
          location: location?.trim().replaceAll(RegExp(r'\s+'), ' '),
        ));
    debugPrint('Updated at hive key $hiveKey');
    customSnackbar(context, 'Wishlist Updated', 20, 20, 20);
    Navigator.of(context!).pop();
  } else {
    debugPrint('Not updated');
  }
}

// ==================== Delete wishlist ====================

deleteWishlist(BuildContext context, Box<Wishlist> wishlistBox, String hiveKey,
    double snackBarBottomPadding) {
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
          Navigator.of(context).pop();

          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();

          // ignore: use_build_context_synchronously
          customSnackbar(
              context, 'Deleted succesfully', snackBarBottomPadding, 20, 20);
          // wishListNotifier.value = wishlistBox.values.toList();
          // wishListNotifier.notifyListeners();
        },
      );
    },
  );
}
