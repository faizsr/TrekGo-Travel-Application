import 'package:flutter/material.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';

List<BoxShadow> kBoxShadow = [
  BoxShadow(
    color: Colors.black.withOpacity(0.04),
    blurRadius: 20,
    spreadRadius: 5,
    offset: const Offset(0, 20),
  )
];

List<BoxShadow> kBoxShadow2 = [
  BoxShadow(
    color: Colors.black.withOpacity(0.04),
    blurRadius: 20,
    spreadRadius: 4,
    offset: const Offset(0, 5),
  )
];

LinearGradient bgGradient = LinearGradient(
  colors: [AppColors.skyBlue, AppColors.aquaBlue],
  stops: const [0.25, 0.88],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
