import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';

// =============== Container for adding, updating images ===============

class AddUpdateImageContainer extends StatelessWidget {
  final DecorationImage? image;
  final Function()? onPressed;
  const AddUpdateImageContainer({
    super.key,
    this.image,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      decoration: BoxDecoration(
        image: image,
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
        // ===== Choose image button =====
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
          onPressed: onPressed,
          child: const Text(
            'CHOOSE IMAGE',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

// =============== Star rating bar ===============

class CardRatingBar extends StatefulWidget {
  final bool isMainAlignCenter;
  final bool isRatingTextNeeded;
  final double? itemSize;
  final double? ratingCount;
  const CardRatingBar({
    super.key,
    this.isMainAlignCenter = false,
    this.isRatingTextNeeded = false,
    this.itemSize,
    this.ratingCount,
  });

  @override
  State<CardRatingBar> createState() => _CardRatingBarState();
}

class _CardRatingBarState extends State<CardRatingBar> {
  double? ratingCount = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: widget.isMainAlignCenter
      //     ? MainAxisAlignment.center
      //     : MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RatingBar(
          ignoreGestures: true,
          itemSize: widget.itemSize ?? 0,
          initialRating: widget.ratingCount ?? 0,
          unratedColor: Colors.grey.shade300,
          glow: false,
          // minRating: 1,
          allowHalfRating: true,
          ratingWidget: RatingWidget(
            full: const Icon(
              Icons.star_rounded,
              color: Color(0xFFFFD711),
            ),
            half: const Icon(
              Icons.star_half_rounded,
              color: Color(0xFFFFD711),
            ),
            empty: const Icon(
              Icons.star_outline_rounded,
              color: Color(0xFFFFD711),
            ),
          ),
          onRatingUpdate: (rating) {
            debugPrint(rating.toString());
            setState(() {
              rating = widget.ratingCount ?? 0;
              // widget.onRatingPlace!(ratingCount);
            });
          },
        ),
        const SizedBox(
          width: 5,
        ),
        widget.isRatingTextNeeded
            ? Text(
                '(${widget.ratingCount})',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Color(0x80000000),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}

// =============== Card Button used for update & delete ===============

class CardButton extends StatelessWidget {
  final String? buttonText;
  const CardButton({
    super.key,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFF1285b9),
        ),
        child: Center(
          child: Text(
            buttonText ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

// =============== Title widget used of sections ===============

class SectionTitles extends StatelessWidget {
  final String titleText;
  final double? noPadding;
  final double? textSize;
  const SectionTitles({
    super.key,
    required this.titleText,
    this.noPadding,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: noPadding ?? 15, bottom: 10, top: noPadding ?? 20),
      child: Text(
        titleText,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: textSize ?? 16,
        ),
      ),
    );
  }
}

// =============== Text form field widget used for add, update ===============

class TextFieldWidgetTwo extends StatelessWidget {
  final String? hintText;
  final bool minmaxLine;
  final bool readOnly;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool? enableInteractiveSelection;
  const TextFieldWidgetTwo({
    super.key,
    this.hintText,
    this.minmaxLine = false,
    this.readOnly = false,
    this.onChanged,
    this.controller,
    this.validator,
    this.keyboardType,
    this.enableInteractiveSelection,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: TextFormField(
        enableInteractiveSelection: enableInteractiveSelection,
        keyboardType: keyboardType,
        keyboardAppearance: Brightness.light,
        readOnly: readOnly,
        validator: validator,
        controller: controller,
        minLines: null,
        maxLines: minmaxLine ? 4 : null,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          isDense: true,
          errorMaxLines: 1,
          errorText: '',
          errorStyle: const TextStyle(
            height: 0,
            fontSize: 0,
            color: Colors.transparent,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0x66000000),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              color: Colors.black12,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              color: Colors.black12,
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              color: Colors.black12,
              width: 2.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              color: Colors.black12,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}

// =============== Custom Appbar ===============

class CustomAppbar extends StatelessWidget {
  final String? sortName;
  final String? title;
  final double? iconPadding;
  final double? titlePadding;
  final double? toolBarHeight;  
  final bool isLocationEnable;
  final bool showCheckIcon;
  final bool isLoading;
  final Function()? onTap;
  const CustomAppbar({
    super.key,
    this.sortName,
    this.title,
    this.iconPadding,
    this.titlePadding,
    this.toolBarHeight,
    this.isLocationEnable = true,
    this.showCheckIcon = false,
    this.isLoading = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () => Navigator.pop(context, 'refresh'),
        child: Padding(
          padding: EdgeInsets.only(top: iconPadding ?? 8),
          child: const CircleAvatar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            child: Icon(
              Icons.keyboard_backspace_rounded,
              color: Colors.black,
              size: 25,
            ),
          ),
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(top: titlePadding ?? 0),
        child: Column(
          children: [
            Text(
              title ?? '',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
            isLocationEnable
                ? SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          MdiIcons.mapMarkerOutline,
                          size: 12,
                          color: Colors.black,
                        ),
                        const Text(
                          'India',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
      actions: [
        showCheckIcon
            ? Padding(
                padding: const EdgeInsets.only(top: 2, right: 10),
                child: GestureDetector(
                  onTap: onTap,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.transparent,
                    child: Icon(
                      MdiIcons.check,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
      centerTitle: true,
      toolbarHeight: toolBarHeight ?? 100,
      elevation: 0,
      backgroundColor: AppColors.skyBlue,
    );
  }
}
