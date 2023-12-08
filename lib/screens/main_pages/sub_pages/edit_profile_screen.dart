import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/helper/auth_db_function.dart';
import 'package:trekmate_project/helper/helper_functions.dart';
import 'package:trekmate_project/screens/user/widget/widgets.dart';
import 'package:trekmate_project/widgets/reusable_widgets/alerts_and_navigates.dart';
import 'package:trekmate_project/widgets/reusable_widgets/reusable_widgets.dart';

class EditProfileScreen extends StatefulWidget {
  final String? userId;
  final String? image;
  final String? fullName;
  final String? gender;
  final String? mobileNumber;
  final String? email;
  final double? snackBarBtmPadding;
  const EditProfileScreen({
    super.key,
    this.userId,
    this.image,
    this.fullName,
    this.gender,
    this.mobileNumber,
    this.email,
    this.snackBarBtmPadding,
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
  String? trimmedName;
  bool isLoading = false;

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

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
        child: CustomAppbar(
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
              isLoading: isLoading,
              setLoadingCallback: setLoading,
              snackBarBtmPadding: widget.snackBarBtmPadding,
            );
            debugPrint('isloading: $isLoading');
          },
        ),
      ),

      // ===== Body =====
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.threeArchedCircle(
                color: const Color(0xFF1485b9),
                size: 40,
              ),
            )
          : SingleChildScrollView(
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
                                  : CachedNetworkImageProvider(
                                      widget.image ?? ''),
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
                            trimmedName = value!.trim();
                            debugPrint(
                                'value name on validation: ${trimmedName ?? 'name'}');
                            if (trimmedName!.isEmpty) {
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
                            onGenderSelectionChange: updateGenderSelection,
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
                            // if (val!.isEmpty) {
                            //   return null;
                            // } else
                            if (val!.isNotEmpty) {
                              if (!(RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)'))
                                  .hasMatch(val)) {
                                customSnackbar(context,
                                    'Please enter a valid number', 20, 20, 20);
                                return '';
                              }
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
                          enableInteractiveSelection: false,
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
