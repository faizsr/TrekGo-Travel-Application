import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trekmate_project/screens/Admin/add_place_rating_widget.dart';
import 'package:trekmate_project/service/database_service.dart';
import 'package:trekmate_project/widgets/Reusable%20widgets/text_form_field.dart';

import 'package:trekmate_project/widgets/Reusable%20widgets/section_titles.dart';
import 'package:trekmate_project/widgets/choice%20chips%20and%20drop%20down%20widget/drop_down_widget.dart';

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
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context, 'refresh'),
          child: const Padding(
            padding: EdgeInsets.only(top: 30),
            child: Icon(
              Icons.keyboard_backspace_rounded,
              color: Colors.black,
              size: 25,
            ),
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.only(top: 30),
          child: Text(
            'Add New Destination',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
        ),
        centerTitle: true,
        toolbarHeight: 90,
        elevation: 0,
        backgroundColor: const Color(0xFFe5e6f6),
      ),

      // ===== Body =====
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== Image Container =====
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                decoration: BoxDecoration(
                  image: _selectedImage != null
                      ? DecorationImage(
                          image: FileImage(File(_selectedImage!.path)),
                          fit: BoxFit.cover,
                        )
                      : DecorationImage(
                          image: NetworkImage(widget.placeImage!),
                          fit: BoxFit.cover,
                        ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 10,
                      color: Color(0x0D000000),
                      spreadRadius: 2,
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.28,
                child: Center(
                  // ===== Choose image button =====
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () async {
                        XFile? pickedImage = await pickImageFromGallery();
                        setState(() {
                          _selectedImage = pickedImage;
                        });
                      },
                      child: const Text(
                        'CHOOSE IMAGE',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      )),
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
                  DropDownWidget(
                    updateCategory: initialCategory,
                    updateState: initialState,
                    leftPadding: 20,
                    listSelect: true,
                    onCategorySelectionChange: updateCategorySelection,
                    validator: (val) {
                      if (val == null) {
                        return 'This field is required';
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
                        return 'This field is required';
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
                    return 'This field is required';
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
                    return 'This field is required';
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
                    return 'This field is required';
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

              // ===== Save button =====
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.05,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFe5e6f6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    side: const BorderSide(
                      color: Color(0xFF1285b9),
                    ),
                  ),
                  onPressed: () async {
                    updateDetails();
                  },
                  child: const Text(
                    'SAVE',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1285b9),
                    ),
                  ),
                ),
              )
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
    } else {
      debugPrint('Not updated');
    }
  }
}
