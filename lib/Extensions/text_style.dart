import 'package:flutter/material.dart';

extension AppTextStyles on TextStyle {
  static const TextStyle mediumTextBold = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 18,
    height: 1.0,
    letterSpacing: 0.0,
    color: Color.fromARGB(255, 255, 255, 255),
  );

  static const TextStyle headerTitle = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 50,
    height: 1.2,
    color: Colors.white,
  );

  static const TextStyle normalTextRegular = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 16,
    height: 1.0,
    color: Colors.white,
  );

  static const TextStyle normalTextBold = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 16,
    height: 1.0,
    color: Colors.white,
  );

  static const TextStyle headerTextBold = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600, // SemiBold
    fontSize: 30,
    height: 1.5, // Line height: 45px / Font size: 30px = 1.5
    letterSpacing: 0,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle largeTextRegular = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.normal, // Regular
    fontSize: 20,
    height: 1.5, // Line height: 30px / Font size: 20px = 1.5
    letterSpacing: 0,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle smallTextRegular = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
    fontSize: 14,
    height: 1.0,
    color: Colors.black,
  );

  static const TextStyle smallTextBold = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 14,
    height: 1.0,
    color: Colors.black,
  );

  static const TextStyle smallerTextRegular = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 11,
    height: 1.65,
    color: Colors.black,
  );

  static const TextStyle smallerTextSmallLabel = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 8,
    height: 1.65,
    color: Colors.black,
  );

  static const TextStyle smallerTextSemiBold = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: 11,
    height: 1.0,
    color: Colors.black,
  );

  static const TextStyle smallerTextBold = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 11,
    height: 1.0,
    color: Colors.black,
  );

  static const TextStyle largeTextBold = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 20,
    height: 1.5,
    color: Colors.black,
  );

  static const TextStyle labelRegular = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 14,
    height: 1.5,
    color: Colors.black,
  );
}
