import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

// =============== Custom Snackbar ===============

void customSnackbar(context, message, double bottomMargin, double rightMargin,
    double leftMargin) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 13,
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
        textAlign: TextAlign.center,
      ),
      // backgroundColor: const Color(0xFF1285b9),
      backgroundColor: const Color(0xFF1285b9),
      duration: const Duration(milliseconds: 1000),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(
          bottom: bottomMargin, right: rightMargin, left: leftMargin),
    ),
  );
}

// =============== Custom alert dialog ===============

class CustomAlertDialog extends StatefulWidget {
  final String? title;
  final bool disableTitle;
  final String? description;
  final double? descriptionTxtSize;
  final bool? disableActionBtn;
  final String? popBtnText;
  final Function()? onTap;
  final String? actionBtnTxt;
  const CustomAlertDialog({
    super.key,
    this.title,
    this.disableTitle = true,
    this.description,
    this.descriptionTxtSize,
    this.onTap,
    this.disableActionBtn = false,
    this.popBtnText,
    this.actionBtnTxt,
  });

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: const Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: widget.disableTitle ? 15 : 0),
          widget.disableTitle
              ? Text(
                  widget.title ?? '',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : const SizedBox(),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: Text(
              widget.description ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: widget.descriptionTxtSize ?? 13),
            ),
          ),
          const SizedBox(height: 10),
          Divider(
            height: 1.2,
            color: Colors.grey.shade200,
          ),
          widget.disableActionBtn == false
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 48,
                  child: InkWell(
                    highlightColor: Colors.grey[200],
                    onTap: widget.onTap,
                    child: Center(
                      child: Text(
                        widget.actionBtnTxt ?? 'Delete',
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFF1285b9),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          Divider(
            height: widget.disableActionBtn == false ? 1.2 : 0,
            color: Colors.grey.shade200,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 48,
            child: InkWell(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15),
              ),
              highlightColor: Colors.grey[200],
              onTap: () {
                Navigator.of(context).pop('refresh');
              },
              child: Center(
                child: Text(
                  widget.popBtnText != null
                      ? widget.popBtnText ?? ''
                      : 'Cancel',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// =============== Next screen navigation ===============

nextScreen(context, page) {
  Navigator.push(
    context,
    PageTransition(
      child: page,
      type: PageTransitionType.fade,
    ),
  );
}

// =============== Next screen replace ===============

nextScreenReplace(context, page) {
  Navigator.pushReplacement(
    context,
    PageTransition(
      child: page,
      type: PageTransitionType.fade,
    ),
  );
}

// =============== Next screen remove until ===============

nextScreenRemoveUntil(context, page) {
  Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        child: page,
        type: PageTransitionType.fade,
      ),
      (route) => false);
}

// =============== Custom status bar color ===============

void setStatusBarColor(Color color) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: color,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}

// =============== Reseting status bar color ===============

void resetStatusBarColor() {
  setStatusBarColor(
    const Color(0xFFe5e6f6),
  );
}

// =============== Scroll behavior ===============

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

// =============== String Capitalise ===============

extension MyExtension on String {
  String capitalise() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String capitaliseAllWords() {
    return split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }
}

// =============== Date Formatter ===============

String formatDate(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  String formattedDate = DateFormat('MMM d, yyyy').format(dateTime);
  return formattedDate;
}
