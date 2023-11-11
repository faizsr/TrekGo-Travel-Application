import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/widgets/Reusable%20widgets/text_form_field.dart';
import 'package:trekmate_project/widgets/Reusable%20widgets/section_titles.dart';
import 'package:trekmate_project/widgets/appbar_title_items.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // ===== Body =====
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.1,
            color: const Color(0xFFe5e6f6),
            child: const Padding(
              padding: EdgeInsets.only(top: 30),
              child: AppbarTitleItems(
                appbarTitleText: 'Edit Profile',
                iconSize: 28,
                titleSize: 18,
                isTrailingNeeded: true,
              ),
            ),
          ),
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
                  backgroundImage: AssetImage(athirapally),
                ),
              ),

              // ===== Button for picking image from camera =====
              Positioned(
                bottom: 10,
                right: 2,
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
            ],
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ===== Name section =====
              Padding(
                padding: EdgeInsets.only(left: 12),
                child: SectionTitles(
                  titleText: 'Name',
                ),
              ),
              TextFieldWidgetTwo(
                hintText: 'Adam Bekh',
              ),

              // ===== Gender section =====
              Padding(
                padding: EdgeInsets.only(left: 12),
                child: SectionTitles(
                  titleText: 'Gender',
                ),
              ),
              TextFieldWidgetTwo(
                hintText: 'Male',
              ),

              // ===== Username =====
              Padding(
                padding: EdgeInsets.only(left: 12),
                child: SectionTitles(
                  titleText: 'Username',
                ),
              ),
              TextFieldWidgetTwo(
                hintText: 'adambekh',
              ),

              // ===== Email section =====
              Padding(
                padding: EdgeInsets.only(left: 12),
                child: SectionTitles(
                  titleText: 'Email',
                ),
              ),
              TextFieldWidgetTwo(
                hintText: 'adambekh@gmail.com',
              ),
            ],
          )
        ],
      ),
    );
  }
}
