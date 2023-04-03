import 'package:flutter/material.dart';

import '../Extensions/Colors.dart';
import '../extensions/text_style.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;

  const AppTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: AppTextStyles.smallTextRegular,
      obscureText: obscureText,
      controller: controller,
      cursorColor: AppColors.accentColor,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.smallerTextRegular,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.accentColor),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondaryTextColor),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
