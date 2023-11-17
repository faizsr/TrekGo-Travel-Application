import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trekmate_project/model/favorite.dart';
import 'package:trekmate_project/widgets/chips_and_drop_downs/drop_down_widget.dart';
import 'package:trekmate_project/widgets/home_screen_widgets/pop_and_recd_appbar.dart';
import 'package:trekmate_project/widgets/reusable_widgets/section_titles.dart';
import 'package:trekmate_project/widgets/reusable_widgets/text_form_field.dart';

class UpdateWishlistScreen extends StatefulWidget {
  final int? index;
  final String? image;
  final String? name;
  final String? state;
  final String? description;
  final String? location;
  const UpdateWishlistScreen({
    super.key,
    this.index,
    this.image,
    this.name,
    this.state,
    this.description,
    this.location,
  });

  @override
  State<UpdateWishlistScreen> createState() => _UpdateWishlistScreenState();
}

class _UpdateWishlistScreenState extends State<UpdateWishlistScreen> {
  String? selectedState;
  String? initialState;

  void updateStateSelection(String? category) {
    selectedState = category;
  }

  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  late final TextEditingController locationController;

  final _formKey = GlobalKey<FormState>();

  XFile? _selectedImage;
  late Box<Favorites> favoriteBox;

  @override
  void initState() {
    super.initState();
    favoriteBox = Hive.box('favorites');
    nameController = TextEditingController(text: widget.name);
    descriptionController = TextEditingController(text: widget.description);
    locationController = TextEditingController(text: widget.location);
    initialState = widget.state;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ===== Appbar =====
   appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size * 0.1,
        child: const PlaceScreenAppbar(
          title: 'Update Wishlist',
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
                      : DecorationImage(
                          image: FileImage(File(widget.image.toString())),
                          fit: BoxFit.cover),
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
                  updateState: initialState,
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
                      favoriteBox.putAt(
                          widget.index ?? 0,
                          Favorites(
                            image: _selectedImage?.path ?? widget.image,
                            state: selectedState,
                            name: nameController.text,
                            description: descriptionController.text,
                            location: locationController.text,
                          ));
                      debugPrint('Data added');
                    }
                    debugPrint(selectedState);
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
