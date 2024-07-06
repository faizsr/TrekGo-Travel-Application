import 'package:flutter/material.dart';

List<BoxShadow> kBoxShadow = [
  BoxShadow(
    color: Colors.black.withOpacity(0.04),
    blurRadius: 20,
    spreadRadius: 5,
    offset: const Offset(0, 20),
  )
];

LinearGradient bgGradient = const LinearGradient(
  colors: [
    Color(0xFFC0F8FE),
    Color(0xFFF0F3F7),
  ],
  stops: [0.25, 0.87],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
