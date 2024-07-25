import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:trekgo_project/src/config/utils/gap.dart';
import 'package:trekgo_project/src/config/utils/validations.dart';
import 'package:trekgo_project/changer/helper/helper_functions.dart';
import 'package:trekgo_project/src/feature/admin/presentation/controllers/manage_destination_controller.dart';
import 'package:trekgo_project/src/feature/admin/presentation/widgets/add_update_image_card.dart';
import 'package:trekgo_project/src/feature/admin/presentation/widgets/admin_appbar.dart';
import 'package:trekgo_project/src/feature/admin/presentation/widgets/drop_down_widget.dart';
import 'package:trekgo_project/src/feature/admin/presentation/widgets/text_form_field_two.dart';
import 'package:trekgo_project/src/feature/destination/domain/entities/destination_entity.dart';

class UpdatePlaceScreen extends StatefulWidget {
  final DestinationEntity destination;
  const UpdatePlaceScreen({super.key, required this.destination});

  @override
  State<UpdatePlaceScreen> createState() => _UpdatePlaceScreenState();
}

class _UpdatePlaceScreenState extends State<UpdatePlaceScreen> {
  XFile? _selectedImage;
  String? imageUrl;
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

  // ===== Text controllers =====
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  final mapLinkController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.destination.name;
    descriptionController.text = widget.destination.description;
    locationController.text = widget.destination.location;
    mapLinkController.text = widget.destination.mapUrl;
    initialCategory = widget.destination.category;
    initialState = widget.destination.state;
    imageUrl = widget.destination.image;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ===== Appbar =====
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AdminAppbar(
          title: 'Edit Destination',
          enableAction: true,
          onPressed: onCheckPressed,
        ),
      ),

      // ===== Body =====
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== Image Container =====

              AddUpdateImageCard(
                selectedImage: _selectedImage?.path,
                imageUrl: imageUrl,
                onPressed: () async {
                  XFile? pickedImage = await pickImageFromGallery();
                  setState(() {
                    _selectedImage = pickedImage;
                  });
                },
              ),

              // ===== Category section =====
              subHeading('Category'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ===== Popular or Recommended =====
                  Expanded(
                    child: DropDownWidget(
                      iconRightPadding: 5,
                      isExpanded: false,
                      updateCategory: initialCategory,
                      updateState: initialState,
                      rightPadding: 5,
                      listSelect: true,
                      onCategorySelectionChange: updateCategorySelection,
                      validator: defaultValidateInput,
                    ),
                  ),
                  const Gap(width: 10),
                  Expanded(
                    child: DropDownWidget(
                      updateState: initialState,
                      updateCategory: initialCategory,
                      leftPadding: 5,
                      iconRightPadding: 5,
                      isExpanded: false,
                      onStateCelectionChange: updateStateSelection,
                      validator: defaultValidateInput,
                    ),
                  ),
                ],
              ),

              subHeading('Title'),
              TextFieldWidgetTwo(
                controller: titleController,
                hintText: 'Title of the place...',
                minmaxLine: false,
                validator: defaultValidateInput,
              ),

              subHeading('Description'),
              TextFieldWidgetTwo(
                controller: descriptionController,
                hintText: 'Description of the place...',
                minmaxLine: true,
                validator: defaultValidateInput,
              ),

              // ===== Location section =====
              subHeading('Location'),
              TextFieldWidgetTwo(
                controller: locationController,
                hintText: 'Location of the place...',
                minmaxLine: false,
                validator: defaultValidateInput,
              ),

              // ===== Map Link section =====
              subHeading('Map Link'),
              TextFieldWidgetTwo(
                controller: mapLinkController,
                hintText: 'Map link of the place...',
                minmaxLine: false,
                validator: defaultValidateInput,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget subHeading(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 20, 0, 10),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    );
  }

  void onCheckPressed() {
    var manageDestinationCtr =
        Provider.of<ManageDestinationController>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      log('Id: ${widget.destination.id}');
      DestinationEntity destination = DestinationEntity(
        id: widget.destination.id,
        name: titleController.text,
        image: widget.destination.image,
        category: selectedCategory ?? initialCategory!,
        state: selectedState ?? initialState!,
        description: descriptionController.text,
        location: locationController.text,
        mapUrl: mapLinkController.text,
      );
      manageDestinationCtr.updateDestination(destination, _selectedImage);
      if (!manageDestinationCtr.isLoading) {
        log('Here');
        Navigator.pop(context);
      }
    }
  }
}
