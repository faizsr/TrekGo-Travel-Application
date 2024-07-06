import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:trekgo_project/changer/helper/helper_functions.dart';
import 'package:trekgo_project/changer/service/firebase_db_functions.dart';
import 'package:trekgo_project/changer/widgets/chips_and_drop_downs/drop_down_widget.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/alerts_and_navigates.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/reusable_widgets.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/widgets.dart';

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
        child: CustomAppbar(
          title: 'Add Destination',
          isLocationEnable: false,
          // showCheckIcon: isButtonEnable ? true : false,
          showCheckIcon: true,
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
              : () {
                  customSnackbar(context,
                      'Fill all forms to create a new Destination', 20, 20, 20);
                },
          isLoading: isLoading,
        ),
      ),

      // ===== Body =====
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.threeArchedCircle(
                color: const Color(0xFF1485b9),
                size: 40,
              ),
            )
          : SingleChildScrollView(
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

                    // ===== Rating =====
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.black12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SectionTitles(
                            titleText: 'Rate',
                            noPadding: 0,
                          ),
                          Center(
                            child: RatingStarWidget(
                              onUpdate: true,
                              onRatingPlace: updateRatingCount,
                            ),
                          ),
                        ],
                      ),
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: DropDownWidget(
                            iconRightPadding: 5,
                            isExpanded: false,
                            hintText: 'Select Category',
                            listSelect: true,
                            rightPadding: 5,
                            onCategorySelectionChange: updateCategorySelection,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: DropDownWidget(
                            leftPadding: 5,
                            iconRightPadding: 5,
                            isExpanded: false,
                            hintText: 'Select State',
                            onStateCelectionChange: updateStateSelection,
                          ),
                        ),
                      ],
                    ),

                    // ===== State =====

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
                        String trimmedTitle = value!.trim();
                        if (trimmedTitle.isEmpty) {
                          customSnackbar(
                              context, 'Title is required', 20, 20, 20);
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
                        String trimmedDescription = value!.trim();
                        if (trimmedDescription.isEmpty) {
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
                        String trimmedLocation = value!.trim();
                        if (trimmedLocation.isEmpty) {
                          customSnackbar(
                              context, 'Location is required', 20, 20, 20);
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
                        String trimmedMapLink = value!.trim();
                        if (trimmedMapLink.isEmpty) {
                          customSnackbar(
                              context, 'Map Link is required', 20, 20, 20);
                          return;
                        } else {
                          return null;
                        }
                      },
                    ),

                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
