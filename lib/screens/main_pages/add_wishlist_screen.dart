import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trekmate_project/model/favorite.dart';
import 'package:trekmate_project/widgets/chips_and_drop_downs/drop_down_widget.dart';
import 'package:trekmate_project/widgets/home_screen_widgets/pop_and_recd_appbar.dart';
import 'package:trekmate_project/widgets/reusable_widgets/section_titles.dart';
import 'package:trekmate_project/widgets/reusable_widgets/text_form_field.dart';

class AddWishlistScreen extends StatefulWidget {
  const AddWishlistScreen({super.key});

  @override
  State<AddWishlistScreen> createState() => _AddWishlistScreenState();
}

class _AddWishlistScreenState extends State<AddWishlistScreen> {
  String? selectedState;

  void updateStateSelection(String? category) {
    selectedState = category;
  }

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  XFile? _selectedImage;
  late Box<Favorites> favoriteBox;

  @override
  void initState() {
    super.initState();
    favoriteBox = Hive.box('favorites');
  }

  void updateData() {
    setState(() {
      favoriteBox.values.toList();
    });
    debugPrint('Details updated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ===== Appbar =====
      appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size * 0.1,
        child: const PlaceScreenAppbar(
          title: 'Create New Wishlist',
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
                  // ===== Section for image selection =====
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
                          color: Colors.grey),
                    ),
                  ),
                ),
              ),

              // ===== State =====
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: SectionTitles(
                  titleText: 'State',
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DropDownWidget(
                  hintText: 'Select State',
                  rightPadding: 20,
                  leftPadding: 20,
                  onStateCelectionChange: updateStateSelection,
                  validator: (val) {
                    if (val == null) {
                      return 'This field is required';
                    } else {
                      return null;
                    }
                  },
                ),
              ),

              // ===== Title section =====
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: SectionTitles(
                  titleText: 'Title',
                ),
              ),
              TextFieldWidgetTwo(
                controller: nameController,
                hintText: 'Title of the place...',
                minmaxLine: false,
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
              ),

              const SizedBox(
                height: 10,
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();
                      favoriteBox.add(Favorites(
                        state: selectedState,
                        name: nameController.text,
                        description: descriptionController.text,
                        location: locationController.text,
                        image: _selectedImage?.path,
                      ));
                      debugPrint('Data added');
                    }
                    debugPrint(selectedState);
                    updateData();
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
}
