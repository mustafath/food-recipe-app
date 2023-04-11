import 'package:flutter/material.dart';

import '../Extensions/Colors.dart';
import '../extensions/text_style.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final maxLines;
  final maxLength;

  const AppTextField(
      {Key? key,
      required this.hintText,
      required this.controller,
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
      this.maxLength = null,
      this.maxLines = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: maxLength,
      keyboardType: keyboardType,
      style: AppTextStyles.smallTextRegular,
      obscureText: obscureText,
      maxLines: maxLines,
      controller: controller,
      cursorColor: AppColors.accentColor,
      decoration: InputDecoration(
        counterText: "",
        hintText: hintText,
        hintStyle: AppTextStyles.smallerTextRegular,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.accentColor),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.neutralGray),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
