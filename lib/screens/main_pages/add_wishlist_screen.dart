import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trekmate_project/model/wishlist.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/alerts_and_navigates.dart';
import 'package:trekmate_project/widgets/chips_and_drop_downs/drop_down_widget.dart';
import 'package:trekmate_project/widgets/login_signup_widgets/button.dart';
import 'package:trekmate_project/widgets/reusable_widgets/app_update_image_widget.dart';
import 'package:trekmate_project/widgets/reusable_widgets/section_titles.dart';
import 'package:trekmate_project/widgets/reusable_widgets/text_form_field.dart';

class AddWishlistScreen extends StatefulWidget {
  final String? userId;
  const AddWishlistScreen({
    super.key,
    this.userId,
  });

  @override
  State<AddWishlistScreen> createState() => _AddWishlistScreenState();
}

class _AddWishlistScreenState extends State<AddWishlistScreen> {
  String? selectedState;
  int inthiveKey = 0;
  String? hiveKey;
  bool isLoading = false;

  void updateStateSelection(String? category) {
    selectedState = category;
  }

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  XFile? _selectedImage;
  late Box<Wishlist> wishlistBox;

  @override
  void initState() {
    super.initState();
    wishlistBox = Hive.box('wishlists');
    debugPrint('User id on Add Wishlist page: ${widget.userId}');
  }

  void updateData() {
    setState(() {
      wishlistBox.values.toList();
    });
    debugPrint('Details updated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ===== Appbar =====
      appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size * 0.15,
        child: Container(
          height: MediaQuery.of(context).size.height * 015,
          color: const Color(0xFFe5e6f6),
          child: Stack(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    'Create New \nWishlist?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1285b9),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    MdiIcons.contentSaveCheck,
                    size: 28,
                    color: const Color(0xFF1285b9),
                  ),
                ),
              )
            ],
          ),
        ),
      ),

      // ===== Body =====
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      customSnackbar(
                          context, 'Please select a category', 0, 20, 20);
                      return;
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
                validator: (val) {
                  if (val!.isEmpty) {
                    customSnackbar(context, 'Title is required', 0, 20, 20);
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
                validator: (val) {
                  if (val!.isEmpty) {
                    customSnackbar(
                        context, 'Description is required', 0, 20, 20);
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
                validator: (val) {
                  if (val!.isEmpty) {
                    customSnackbar(context, 'Location is required', 0, 20, 20);
                    return;
                  } else {
                    return null;
                  }
                },
              ),
              Container(
                padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.085,
                child: ButtonsWidget(
                  buttonTextSize: 16,
                  buttonBorderRadius: 15,
                  buttonTextWeight: FontWeight.w600,
                  buttonText:
                      isLoading ? 'NEW WISHLIST CREATED' : 'SAVE WISHLIST',
                  buttonOnPressed: () {
                    addData();
                  },
                ),
              ),

              Container(
                padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.085,
                child: ButtonsWidget(
                  buttonTextSize: 16,
                  buttonBorderRadius: 15,
                  buttonTextWeight: FontWeight.w600,
                  buttonText:
                      isLoading ? 'NEW WISHLIST CREATED' : 'SAVE WISHLIST',
                  buttonOnPressed: () {
                    addData();
                  },
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.13,
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

  addData() {
    if (_formKey.currentState!.validate() &&
        _selectedImage != null &&
        selectedState != null) {
      setState(() {
        isLoading = true;
      });
      inthiveKey = DateTime.now().millisecondsSinceEpoch;
      _formKey.currentState?.save();
      hiveKey = inthiveKey.toString();
      debugPrint('Added at hive key: $hiveKey');
      debugPrint('Added in the user id ${widget.userId}');
      wishlistBox.put(
          hiveKey,
          Wishlist(
            hiveKey: hiveKey,
            userId: widget.userId,
            state: selectedState,
            name: nameController.text,
            image: _selectedImage?.path,
            description: descriptionController.text,
            location: locationController.text,
          ));
      customSnackbar(context, 'New wishlist created!', 0, 20, 20);
      debugPrint('Data added');
    } else {
      setState(() {
        isLoading = false;
      });
      customSnackbar(context, 'Fill all forms!', 0, 20, 20);
      debugPrint('Details not updated');
    }
    setState(() {
      isLoading = false;
    });
    debugPrint(selectedState);
    updateData();
  }
}
