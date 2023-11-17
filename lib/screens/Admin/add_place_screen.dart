import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trekmate_project/screens/admin/add_place_rating_widget.dart';
import 'package:trekmate_project/screens/Bottom%20page%20navigator/bottom_navigation_bar.dart';
import 'package:trekmate_project/service/database_service.dart';
import 'package:trekmate_project/widgets/chips_and_drop_downs/drop_down_widget.dart';
import 'package:trekmate_project/widgets/home_screen_widgets/pop_and_recd_appbar.dart';
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
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ===== Appbar =====
      appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size * 0.1,
        child: const PlaceScreenAppbar(
          title: 'Add Destination',
          isLocationEnable: false,
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
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                decoration: BoxDecoration(
                  image: _selectedImage != null
                      ? DecorationImage(
                          image: FileImage(File(_selectedImage!.path)),
                          fit: BoxFit.cover,
                        )
                      : null,
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
                    ),
                  ),
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
                    hintText: 'Select Category',
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
                    hintText: 'Select State',
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
                controller: _titleController,
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
                controller: _descriptionController,
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
                controller: _locationController,
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
                    // ===== Saving image to firestore database =====
                    await addPlace();
                  },
                  child: isLoading
                      ? const SizedBox(
                          width: 15,
                          height: 15,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF1285b9),
                              strokeWidth: 2,
                            ),
                          ),
                        )
                      : const Text(
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

  // ====== Adding new place function ======
  addPlace() async {
    if (_formKey.currentState!.validate() &&
        _selectedImage != null &&
        ratingCount != null) {
      setState(() {
        isLoading = true;
      });
      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child('images');
      Reference referenceImageToUpload =
          referenceDirImages.child(uniqueFileName);

      try {
        await referenceImageToUpload.putFile(File(_selectedImage!.path));
        imageUrl = await referenceImageToUpload.getDownloadURL();
      } catch (e) {
        debugPrint(e.toString());
      } finally {
        setState(() {
          isLoading = false;
        });
      }
      debugPrint(uniqueFileName);
      DatabaseService().savingDestination(
        selectedCategory!,
        selectedState!,
        imageUrl!,
        _titleController.text.trim(),
        _descriptionController.text.trim(),
        _locationController.text.trim(),
        ratingCount!,
      );
      debugPrint(selectedCategory);
      debugPrint(selectedState);

      debugPrint('Data successfully added');
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const NavigationBottomBar(
            isAdmin: true,
            isUser: false,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all forms'),
        ),
      );
    }
  }
}
