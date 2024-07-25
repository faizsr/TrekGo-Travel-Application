import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trekgo_project/changer/helper/helper_functions.dart';
import 'package:trekgo_project/src/feature/admin/presentation/widgets/add_update_image_card.dart';
import 'package:trekgo_project/src/feature/admin/presentation/widgets/admin_appbar.dart';
import 'package:trekgo_project/src/feature/admin/presentation/widgets/drop_down_widget.dart';
import 'package:trekgo_project/src/config/utils/gap.dart';
import 'package:trekgo_project/src/config/utils/validations.dart';
import 'package:trekgo_project/src/feature/admin/presentation/controllers/manage_destination_controller.dart';
import 'package:trekgo_project/src/feature/admin/presentation/widgets/text_form_field_two.dart';
import 'package:trekgo_project/src/feature/destination/domain/entities/destination_entity.dart';

class AddPlacePage extends StatefulWidget {
  const AddPlacePage({super.key});

  @override
  State<AddPlacePage> createState() => _AddPlacePageState();
}

class _AddPlacePageState extends State<AddPlacePage> {
  XFile? _selectedImage;
  String? imageUrl = '';
  String? selectedCategory;
  String? selectedState;

  final _formKey = GlobalKey<FormState>();

  void updateCategorySelection(String? category) {
    selectedCategory = category;
  }

  void updateStateSelection(String? category) {
    selectedState = category;
  }

  // ===== Text controllers =====
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController mapLinkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AdminAppbar(
          title: 'Add Destination',
          enableAction: true,
          onPressed: onCheckPressed,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AddUpdateImageCard(
                selectedImage: _selectedImage?.path,
                onPressed: () async {
                  XFile? pickedImage = await pickImageFromGallery();
                  setState(() {
                    _selectedImage = pickedImage;
                  });
                },
              ),

              subHeading('Category'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: DropDownWidget(
                      listSelect: true,
                      isExpanded: true,
                      hintText: 'Select Category',
                      rightPadding: 5,
                      onCategorySelectionChange: updateCategorySelection,
                      validator: defaultValidateInput,
                    ),
                  ),
                  const Gap(width: 10),
                  Expanded(
                    child: DropDownWidget(
                      listSelect: false,
                      iconRightPadding: 5,
                      isExpanded: true,
                      hintText: 'Select State',
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

              // ===== Description section =====
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
    if (_formKey.currentState!.validate() && _selectedImage!.path.isNotEmpty) {
      DestinationEntity destination = DestinationEntity(
        name: titleController.text,
        image: _selectedImage?.path ?? '',
        category: selectedCategory ?? '',
        state: selectedState ?? '',
        description: descriptionController.text,
        location: locationController.text,
        mapUrl: mapLinkController.text,
      );
      Provider.of<ManageDestinationController>(context, listen: false)
          .addNewDestination(destination);
    } else {
      log('Not Valid');
    }
  }
}
