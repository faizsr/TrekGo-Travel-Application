import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trekmate_project/screens/admin/add_place_rating_widget.dart';
import 'package:trekmate_project/service/database_service.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/alerts_and_navigates.dart';
import 'package:trekmate_project/widgets/chips_and_drop_downs/drop_down_widget.dart';
import 'package:trekmate_project/widgets/home_screen_widgets/pop_and_recd_appbar.dart';
import 'package:trekmate_project/widgets/reusable_widgets/app_update_image_widget.dart';
import 'package:trekmate_project/widgets/reusable_widgets/section_titles.dart';
import 'package:trekmate_project/widgets/reusable_widgets/text_form_field.dart';

class UpdatePlaceScreen extends StatefulWidget {
  final String? placeid;
  final String? placeImage;
  final String? placeCategory;
  final String? placeState;
  final String? placeTitle;
  final String? placeDescription;
  final String? placeLocation;
  final double? placeRating;
  const UpdatePlaceScreen({
    super.key,
    this.placeid,
    this.placeImage,
    this.placeCategory,
    this.placeState,
    this.placeTitle,
    this.placeDescription,
    this.placeLocation,
    this.placeRating,
  });
  @override
  State<UpdatePlaceScreen> createState() => _UpdatePlaceScreenState();
}

class _UpdatePlaceScreenState extends State<UpdatePlaceScreen> {
  XFile? _selectedImage;
  String? imageUrl;
  double? ratingCount;
  String? selectedCategory;
  String? initialCategory;
  String? selectedState;
  String? initialState;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  void updateCategorySelection(String? category) {
    selectedCategory = category;
  }

  void updateStateSelection(String? category) {
    selectedState = category;
  }

  void updateRatingCount(double? rating) {
    ratingCount = rating;
  }

  // ===== Text controllers =====
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.placeTitle!;
    descriptionController.text = widget.placeDescription!;
    locationController.text = widget.placeLocation!;
    ratingCount = widget.placeRating;
    initialCategory = widget.placeCategory;
    initialState = widget.placeState;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ===== Appbar =====
      appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size * 0.1,
        child: PlaceScreenAppbar(
          title: 'Update Destination',
          isLocationEnable: false,
          showCheckIcon: true,
          onTap: () => updateDetails(),
        ),
      ),

      // ===== Body =====
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== Image Container =====

              AddUpdateImageContainer(
                image: _selectedImage != null
                    ? DecorationImage(
                        image: FileImage(File(_selectedImage!.path)),
                        fit: BoxFit.cover,
                      )
                    : DecorationImage(
                        image: NetworkImage(widget.placeImage!),
                        fit: BoxFit.cover,
                      ),
                onPressed: () async {
                  XFile? pickedImage = await pickImageFromGallery();
                  setState(() {
                    _selectedImage = pickedImage;
                  });
                },
              ),

              // ===== Category section =====
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: SectionTitles(
                  titleText: 'Category',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ===== Popular or Recommended =====
                  DropDownWidget(
                    updateCategory: initialCategory,
                    updateState: initialState,
                    leftPadding: 20,
                    listSelect: true,
                    onCategorySelectionChange: updateCategorySelection,
                    validator: (val) {
                      if (val == null) {
                        customSnackbar(
                            context, 'Please select a category', 20, 20, 20);
                        return;
                      } else {
                        return null;
                      }
                    },
                  ),

                  // ===== State =====
                  DropDownWidget(
                    updateState: initialState,
                    updateCategory: initialCategory,
                    rightPadding: 20,
                    onStateCelectionChange: updateStateSelection,
                    validator: (val) {
                      if (val == null) {
                        customSnackbar(
                            context, 'Please select a state', 20, 20, 20);
                        return;
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),

              // ===== Title section =====
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: SectionTitles(
                  titleText: 'Title',
                ),
              ),
              TextFieldWidgetTwo(
                controller: titleController,
                hintText: 'Title of the place...',
                minmaxLine: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    customSnackbar(context, 'Title is required', 20, 20, 20);
                    return;
                  } else {
                    return null;
                  }
                },
              ),

              // ===== Description section =====
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: SectionTitles(titleText: 'Description'),
              ),
              TextFieldWidgetTwo(
                controller: descriptionController,
                hintText: 'Description of the place...',
                minmaxLine: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    customSnackbar(
                        context, 'Description is required', 20, 20, 20);
                    return;
                  } else {
                    return null;
                  }
                },
              ),

              // ===== Location section =====
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: SectionTitles(
                  titleText: 'Location',
                ),
              ),
              TextFieldWidgetTwo(
                controller: locationController,
                hintText: 'Location of the place...',
                minmaxLine: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    customSnackbar(context, 'Location is required', 20, 20, 20);
                    return;
                  } else {
                    return null;
                  }
                },
              ),

              const SizedBox(
                height: 15,
              ),

              // ===== Rating =====
              Center(
                child: RatingStarWidget(
                  onUpdate: true,
                  initialRatingCount: ratingCount,
                  onRatingPlace: updateRatingCount,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===== Function for image picking from gallery =====
  Future<XFile?> pickImageFromGallery() async {
    XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      return XFile(pickedImage.path);
    }
    return null;
  }

  // ===== Function for updating the detials =====
  updateDetails() async {
    Reference referenceImageToUpload =
        FirebaseStorage.instance.refFromURL(widget.placeImage!);

    try {
      await referenceImageToUpload.putFile(File(_selectedImage!.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (e) {
      debugPrint(e.toString());
    }

    // ===== Saving to the database =====
    if (titleController.text.isNotEmpty ||
        descriptionController.text.isNotEmpty ||
        locationController.text.isNotEmpty ||
        ratingCount != null ||
        imageUrl != null ||
        selectedCategory != null ||
        selectedState != null) {
      setState(() {
        isLoading = true;
      });
      await DatabaseService().destinationCollection.doc(widget.placeid).update({
        'place_image': imageUrl ?? widget.placeImage,
        'place_name': titleController.text.trim(),
        'place_description': descriptionController.text.trim(),
        'place_location': locationController.text.trim(),
        'place_rating': ratingCount ?? widget.placeRating,
        'place_category': selectedCategory ?? widget.placeCategory,
        'place_state': selectedState ?? widget.placeState,
      });
      debugPrint('Updated');
      // customSnackbar(context, 'Updated successfully', 20, 20, 20);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Updated successfully'),
        ),
      );
    } else {
      debugPrint('Not updated');
    }
    setState(() {
      isLoading = false;
    });
  }
}
