import 'package:flutter/material.dart';

// ! TextSizes
const double largeHeading = 40;
const double h1 = 28;
const double h2 = 24;
const double h3 = 22;
const double h4 = 20;
const double h5 = 18;
const double body = 14;

// ! Custom TextStyle
TextStyle customTextStyle(double size, FontWeight fw,
    {double letterSpacing = 1, Color textColor = Colors.black}) {
  return TextStyle(
      fontSize: size,
      fontWeight: fw,
      letterSpacing: letterSpacing,
      color: textColor);
}

// ! Colors for the whole app
const primaryColor = Color(0xFF7F3DFF);
const secondaryColor = Color(0xFFEEE5FF);
const primaryTextColor = Color(0xFFFFFFFF);
const successColor = Color(0xFF00A86B);
const dangerColor = Color(0xFFFD3C4A);
