import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trekmate_project/helper/helper_functions.dart';
import 'package:trekmate_project/screens/admin/widget/add_place_rating_widget.dart';
import 'package:trekmate_project/service/firebase_db_functions.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/alerts_and_navigates.dart';
import 'package:trekmate_project/widgets/chips_and_drop_downs/drop_down_widget.dart';
import 'package:trekmate_project/widgets/home_screen_widgets/pop_and_recd_appbar.dart';
import 'package:trekmate_project/widgets/reusable_widgets/app_update_image_widget.dart';
import 'package:trekmate_project/widgets/reusable_widgets/section_titles.dart';
import 'package:trekmate_project/widgets/reusable_widgets/text_form_field.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  XFile? _selectedImage;
  String? imageUrl = '';
  String? selectedCategory;
  String? selectedState;
  double? ratingCount;
  String? title;
  String? location;
  String? description;
  String? mapLink;
  bool isLoading = false;
  bool isButtonEnable = false;
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

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  // ===== Text controllers =====
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController mapLinkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ===== Appbar =====
      appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size * 0.1,
        child: PlaceScreenAppbar(
          title: 'Add Destination',
          isLocationEnable: false,
          showCheckIcon: isButtonEnable ? true : false,
          onTap: isButtonEnable
              ? () {
                  addNewDestination(
                    formKey: _formKey,
                    selectedImage: _selectedImage,
                    ratingCount: ratingCount,
                    setLoadingCallback: setLoading,
                    imageUrl: imageUrl,
                    selectedCategory: selectedCategory,
                    selectedState: selectedState,
                    title: title,
                    description: description,
                    location: location,
                    mapLink: mapLink,
                    context: context,
                  );
                }
              : null,
          isLoading: isLoading,
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
                    : null,
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
                    hintText: 'Select Category',
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
                    hintText: 'Select State',
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
                controller: _titleController,
                hintText: 'Title of the place...',
                minmaxLine: false,
                onChanged: (value) {
                  title = value;
                  setState(() {
                    isButtonEnable = _titleController.text.isNotEmpty &&
                        _descriptionController.text.isNotEmpty &&
                        _locationController.text.isNotEmpty &&
                        mapLinkController.text.isNotEmpty;
                  });
                },
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
                controller: _descriptionController,
                hintText: 'Description of the place...',
                minmaxLine: true,
                onChanged: (value) {
                  description = value;
                  setState(() {
                    isButtonEnable = _titleController.text.isNotEmpty &&
                        _descriptionController.text.isNotEmpty &&
                        _locationController.text.isNotEmpty &&
                        mapLinkController.text.isNotEmpty;
                  });
                },
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
                controller: _locationController,
                hintText: 'Location of the place...',
                minmaxLine: false,
                onChanged: (value) {
                  location = value;
                  setState(() {
                    isButtonEnable = _titleController.text.isNotEmpty &&
                        _descriptionController.text.isNotEmpty &&
                        _locationController.text.isNotEmpty &&
                        mapLinkController.text.isNotEmpty;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    customSnackbar(context, 'Location is required', 20, 20, 20);
                    return;
                  } else {
                    return null;
                  }
                },
              ),

              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: SectionTitles(
                  titleText: 'Map Link',
                ),
              ),
              TextFieldWidgetTwo(
                controller: mapLinkController,
                hintText: 'Map link of the place...',
                minmaxLine: false,
                onChanged: (value) {
                  mapLink = value;
                  setState(() {
                    isButtonEnable = _titleController.text.isNotEmpty &&
                        _descriptionController.text.isNotEmpty &&
                        _locationController.text.isNotEmpty &&
                        mapLinkController.text.isNotEmpty;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    customSnackbar(context, 'Map Link is required', 20, 20, 20);
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
                  onRatingPlace: updateRatingCount,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
