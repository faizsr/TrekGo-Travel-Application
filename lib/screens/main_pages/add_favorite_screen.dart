import 'package:flutter/material.dart';
import 'package:trekmate_project/widgets/reusable_widgets/section_titles.dart';
import 'package:trekmate_project/widgets/reusable_widgets/text_form_field.dart';

class AddFavoriteScreen extends StatelessWidget {
  const AddFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ===== Appbar =====
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Padding(
            padding: EdgeInsets.only(top: 30),
            child: Icon(
              Icons.keyboard_backspace_rounded,
              color: Colors.black,
              size: 25,
            ),
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.only(top: 30),
          child: Text(
            'Your favorites',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
        ),
        centerTitle: true,
        toolbarHeight: 90,
        elevation: 0,
        backgroundColor: const Color(0xFFe5e6f6),
      ),

      // ===== Body =====
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              decoration: BoxDecoration(
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
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ),
                    child: Text(
                      'CHOOSE IMAGE',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),

            // ===== Title section =====
            const Padding(
              padding: EdgeInsets.only(left: 12),
              child: SectionTitles(
                titleText: 'Title',
              ),
            ),
            const TextFieldWidgetTwo(
              hintText: 'Title of the place...',
              minmaxLine: false,
            ),

            // ===== Description section =====
            const Padding(
              padding: EdgeInsets.only(left: 12),
              child: SectionTitles(titleText: 'Description'),
            ),
            const TextFieldWidgetTwo(
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
            const TextFieldWidgetTwo(
              hintText: 'Location of the place...',
              minmaxLine: false,
            ),

            const SizedBox(
              height: 10,
            ),

            // ===== Save button =====
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
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
                onPressed: () {},
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
    );
  }
}
