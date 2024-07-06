import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trekgo_project/changer/helper/helper_functions.dart';
import 'package:trekgo_project/changer/helper/hive_db_function.dart';
import 'package:trekgo_project/changer/model/wishlist.dart';
import 'package:trekgo_project/changer/widgets/chips_and_drop_downs/drop_down_widget.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/alerts_and_navigates.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/reusable_widgets.dart';

class UpdateWishlistScreen extends StatefulWidget {
  final String? hiveKey;
  final String? userId;
  final String? image;
  final String? name;
  final String? state;
  final String? description;
  final String? location;
  const UpdateWishlistScreen({
    super.key,
    this.hiveKey,
    this.userId,
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
  XFile? _selectedImage;
  String? selectedState;
  String? initialState;
  String? imageUrl;
  late Box<Wishlist> wishlistBox;
  List<Wishlist>? filteredPlace;

  void updateStateSelection(String? category) {
    selectedState = category;
  }

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    wishlistBox = Hive.box('wishlists');
    filteredPlace = wishlistBox.values.toList();
    nameController.text = widget.name ?? '';
    descriptionController.text = widget.description ?? '';
    locationController.text = widget.location ?? '';
    initialState = widget.state;
    imageUrl = widget.image.toString();
    debugPrint('index on update wishlist: ${widget.hiveKey}');
    debugPrint('user id on update wishlist: ${widget.userId}');
  }

  void updateDataInHive() {
    setState(() {
      filteredPlace = wishlistBox.values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(const Color(0XFFe5e6f6));

    return Scaffold(
      // ===== Appbar =====
      appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size * 0.1,
        child: CustomAppbar(
          title: 'Update Wishlist',
          isLocationEnable: false,
          showCheckIcon: true,
          onTap: () {
            updateWishlist(
              name: nameController.text.replaceAll(RegExp(r'\s+'), ' '),
              description:
                  descriptionController.text.replaceAll(RegExp(r'\s+'), ' '),
              location: locationController.text.replaceAll(RegExp(r'\s+'), ' '),
              image: widget.image,
              initialState: initialState,
              imageUrl: imageUrl,
              userId: widget.userId,
              hiveKey: widget.hiveKey,
              selectedImage: _selectedImage,
              selectedState: selectedState ?? initialState,
              wishlistBox: wishlistBox,
              context: context,
              formkey: _formKey,
            );
          },
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
                  updateCategory: '',
                  hintText: 'Select State',
                  rightPadding: 20,
                  leftPadding: 20,
                  onStateCelectionChange: updateStateSelection,
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
                  String trimmedTitle = val!.trim();
                  if (trimmedTitle.isEmpty) {
                    customSnackbar(context, 'Title is required', 20, 20, 20);
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
                validator: (val) {
                  String trimmedDescription = val!.trim();
                  if (trimmedDescription.isEmpty) {
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
                validator: (val) {
                  String trimmedLocation = val!.trim();
                  if (trimmedLocation.isEmpty) {
                    customSnackbar(context, 'Location is required', 20, 20, 20);
                    return '';
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

  @override
  void dispose() {
    super.dispose();
    setStatusBarColor(const Color(0xFFc0f8fe));
  }
}
