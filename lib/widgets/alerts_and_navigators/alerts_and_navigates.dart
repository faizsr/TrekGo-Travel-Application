import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

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
      duration: const Duration(milliseconds: 2500),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(
          bottom: bottomMargin, right: rightMargin, left: leftMargin),
    ),
  );
}

nextScreen(context, page) {
  Navigator.push(
    context,
    PageTransition(
      child: page,
      type: PageTransitionType.fade,
    ),
  );
}

nextScreenReplace(context, page) {
  Navigator.pushReplacement(
    context,
    PageTransition(
      child: page,
      type: PageTransitionType.fade,
    ),
  );
}

nextScreenRemoveUntil(context, page) {
  Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        child: page,
        type: PageTransitionType.fade,
      ),
      (route) => false);
}

void setStatusBarColor(Color color) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: const Color(0xFFe5e6f6),
      statusBarColor: color,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}

void resetStatusBarColor() {
  setStatusBarColor(
    const Color(0xFFe5e6f6),
  );
}
