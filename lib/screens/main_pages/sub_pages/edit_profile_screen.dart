import 'dart:io';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/helper/auth_db_function.dart';
import 'package:trekmate_project/helper/helper_functions.dart';
import 'package:trekmate_project/screens/user/widget/edit_gender_drop_down.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/alerts_and_navigates.dart';
import 'package:trekmate_project/widgets/home_screen_widgets/pop_and_recd_appbar.dart';
import 'package:trekmate_project/widgets/reusable_widgets/section_titles.dart';
import 'package:trekmate_project/widgets/reusable_widgets/text_form_field.dart';

class EditProfileScreen extends StatefulWidget {
  final String? userId;
  final String? image;
  final String? fullName;
  final String? gender;
  final String? mobileNumber;
  final String? email;
  const EditProfileScreen({
    super.key,
    this.userId,
    this.image,
    this.fullName,
    this.gender,
    this.mobileNumber,
    this.email,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  XFile? _selectedImage;
  String? selectedGender;
  String? initialGender;
  String? imageUrl;
  final nameController = TextEditingController();
  final mobileNoController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void updateGenderSelection(String? category) {
    selectedGender = category;
  }

  @override
  void initState() {
    nameController.text = widget.fullName ?? '';
    mobileNoController.text = widget.mobileNumber ?? '';
    emailController.text = widget.email ?? '';
    initialGender = widget.gender;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(const Color(0XFFe5e6f6));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size * 0.1,
        child: PlaceScreenAppbar(
          title: 'Edit Profile',
          isLocationEnable: false,
          showCheckIcon: true,
          onTap: () {
            updateUserDetailss(
              name: nameController.text..replaceAll(RegExp(r'\s+'), ' '),
              email: emailController.text,
              mobile: mobileNoController.text,
              image: widget.image,
              userId: widget.userId,
              imageUrl: imageUrl,
              selectedGender: selectedGender ?? initialGender ?? '',
              selectedImage: _selectedImage,
              context: context,
              formKey: formKey,
            );
          },
        ),
      ),

      // ===== Body =====
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Stack(
              children: [
                // ===== User profile picture =====
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(80),
                      border: Border.all(width: 2.5, color: Colors.white),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 17,
                          spreadRadius: 6,
                          color: Color(0x0D000000),
                        )
                      ]),
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage(defaultImage),
                    foregroundImage: _selectedImage != null
                        ? Image.file(File(_selectedImage!.path)).image
                        : widget.image == ''
                            ? Image.asset(defaultImage).image
                            : Image.network(widget.image ?? '').image,
                  ),
                ),

                // ===== Button for picking image from camera =====
                Positioned(
                  bottom: 12,
                  right: 6,
                  child: GestureDetector(
                    onTap: () async {
                      XFile? pickedImage = await pickImageFromGallery();
                      setState(() {
                        _selectedImage = pickedImage;
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.08,
                      height: MediaQuery.of(context).size.height * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                      child: const Icon(
                        FeatherIcons.camera,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== Name section =====
                  const Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: SectionTitles(
                      titleText: 'Full Name',
                    ),
                  ),
                  TextFieldWidgetTwo(
                    controller: nameController,
                    hintText: 'Full name',
                    validator: (value) {
                      if (value!.isEmpty) {
                        customSnackbar(
                            context, 'Please enter a name', 20, 20, 20);
                        return '';
                      } else {
                        return null;
                      }
                    },
                  ),

                  // ===== Gender section =====
                  const Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: SectionTitles(
                      titleText: 'Gender',
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: EditDropDownWidget(
                      updateGender: initialGender ?? 'Male',
                      hintText: 'Gender',
                      rightPadding: 20,
                      leftPadding: 20,
                      onGenderSelectionChange: updateGenderSelection,
                      validator: (val) {
                        if (val == null) {
                          return '';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),

                  // ===== Phone number =====
                  const Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: SectionTitles(
                      titleText: 'Phone Number',
                    ),
                  ),
                  TextFieldWidgetTwo(
                    keyboardType: TextInputType.phone,
                    controller: mobileNoController,
                    hintText: 'Phone number',
                    validator: (val) {
                      if (val!.isEmpty) {
                        return null;
                      } else if (!(RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)'))
                          .hasMatch(val)) {
                        customSnackbar(
                            context, 'Please enter a valid number', 20, 20, 20);
                        return '';
                      }
                      return null;
                    },
                  ),

                  // ===== Email section =====
                  const Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: SectionTitles(
                      titleText: 'Email Address',
                    ),
                  ),
                  TextFieldWidgetTwo(
                    controller: emailController,
                    readOnly: true,
                    hintText: 'Email address',
                  ),
                ],
              ),
            )
          ],
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
