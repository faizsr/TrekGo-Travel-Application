import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trekmate_project/model/favorite.dart';
import 'package:trekmate_project/widgets/alert_dialog/alerts_and_navigates.dart';
import 'package:trekmate_project/widgets/chips_and_drop_downs/drop_down_widget.dart';
import 'package:trekmate_project/widgets/home_screen_widgets/pop_and_recd_appbar.dart';
import 'package:trekmate_project/widgets/reusable_widgets/app_update_image_widget.dart';
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
        child: PlaceScreenAppbar(
          title: 'Update Wishlist',
          isLocationEnable: false,
          showCheckIcon: true,
          onTap: () => updateData(),
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
                    : DecorationImage(
                        image: FileImage(File(widget.image.toString())),
                        fit: BoxFit.cover,
                      ),
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
                  updateState: initialState,
                  hintText: 'Select State',
                  rightPadding: 20,
                  leftPadding: 20,
                  onStateCelectionChange: updateStateSelection,
                  validator: (val) {
                    if (val == null) {
                      customSnackbar(
                          context, 'Please select a category', 20, 20, 20);
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
                validator: (val) {
                  if (val!.isEmpty) {
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
                validator: (val) {
                  if (val!.isEmpty) {
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
                validator: (val) {
                  if (val!.isEmpty) {
                    customSnackbar(context, 'Location is required', 20, 20, 20);
                    return;
                  } else {
                    return null;
                  }
                },
              ),

              const SizedBox(
                height: 10,
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

  updateData() {
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
  }
}
