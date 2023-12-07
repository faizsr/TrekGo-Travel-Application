import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:trekmate_project/helper/helper_functions.dart';
import 'package:trekmate_project/screens/admin/widget/add_place_rating_widget.dart';
import 'package:trekmate_project/service/firebase_db_functions.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/alerts_and_navigates.dart';
import 'package:trekmate_project/widgets/chips_and_drop_downs/drop_down_widget.dart';
import 'package:trekmate_project/widgets/home_screen_widgets/pop_and_recd_appbar.dart';
import 'package:trekmate_project/widgets/reusable_widgets/app_update_image_widget.dart';

class UpdatePlaceScreen extends StatefulWidget {
  final String? placeid;
  final String? placeImage;
  final String? placeCategory;
  final String? placeState;
  final String? placeTitle;
  final String? placeDescription;
  final String? placeLocation;
  final String? placeMapLink;
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
    this.placeMapLink,
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
  final mapLinkController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.placeTitle!;
    descriptionController.text = widget.placeDescription!;
    locationController.text = widget.placeLocation!;
    mapLinkController.text = widget.placeMapLink ?? '';
    ratingCount = widget.placeRating;
    initialCategory = widget.placeCategory;
    initialState = widget.placeState;
    imageUrl = widget.placeImage;
    super.initState();
  }

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(const Color(0XFFe5e6f6));
    return Scaffold(
      // ===== Appbar =====
      appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size * 0.1,
        child: PlaceScreenAppbar(
          title: 'Update Destination',
          isLocationEnable: false,
          showCheckIcon: true,
          onTap: () {
            updateDestinationn(
              context: context,
              title: titleController.text.replaceAll(RegExp(r'\s+'), ' '),
              description:
                  descriptionController.text.replaceAll(RegExp(r'\s+'), ' '),
              location: locationController.text.replaceAll(RegExp(r'\s+'), ' '),
              selectedImage: _selectedImage,
              imageUrl: imageUrl ?? widget.placeImage,
              ratingCount: ratingCount ?? widget.placeRating,
              initialCategory: initialCategory,
              initialState: initialState,
              selectedCategory: selectedCategory ?? widget.placeCategory,
              selectedState: selectedState ?? widget.placeState,
              placeId: widget.placeid,
              placeImage: widget.placeImage,
              mapLink: mapLinkController.text,
              setLoadingCallback: setLoading,
              formkey: _formKey,
            );
          },
        ),
      ),

      // ===== Body =====
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.threeArchedCircle(
                  color: const Color(0xFF1485b9), size: 40),
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
                              isTextNeeded: true,
                              initialRatingCount: ratingCount,
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
                        // ===== Popular or Recommended =====
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: DropDownWidget(
                            iconRightPadding: 5,
                            isExpanded: false,
                            updateCategory: initialCategory,
                            updateState: initialState,
                            rightPadding: 5,
                            listSelect: true,
                            onCategorySelectionChange: updateCategorySelection,
                          ),
                        ),

                        // ===== State =====
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: DropDownWidget(
                            updateState: initialState,
                            updateCategory: initialCategory,
                            leftPadding: 5,
                            iconRightPadding: 5,
                            isExpanded: false,
                            onStateCelectionChange: updateStateSelection,
                          ),
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
                        String trimmedTitle = value!.trim();
                        if (trimmedTitle.isEmpty) {
                          customSnackbar(
                              context, 'Title is required', 20, 20, 20);
                          return '';
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
                        String trimmedDescription = value!.trim();
                        if (trimmedDescription.isEmpty) {
                          debugPrint('Descripiton is empty');
                          customSnackbar(
                              context, 'Description is required', 20, 20, 20);
                          return '';
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
                        String trimmedLocation = value!.trim();
                        if (trimmedLocation.isEmpty) {
                          customSnackbar(
                              context, 'Location is required', 20, 20, 20);
                          return '';
                        } else {
                          return null;
                        }
                      },
                    ),

                    // ===== Map Link section =====
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
                      validator: (value) {
                        String trimmedMapLink = value!.trim();
                        if (trimmedMapLink.isEmpty) {
                          customSnackbar(
                              context, 'Location is required', 20, 20, 20);
                          return '';
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

  @override
  void dispose() {
    super.dispose();
    setStatusBarColor(const Color(0xFFc0f8fe));
  }
}
