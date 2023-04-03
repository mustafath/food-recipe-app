import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SocialMediaButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback onPressed;

  SocialMediaButton({required this.onPressed, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shadowColor: MaterialStateProperty.all<Color>(
              Color.fromRGBO(105, 105, 105, 0.1)),
          elevation: MaterialStateProperty.all<double>(5),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: Image.asset(
          iconPath,
        ),
      ),
    );
  }
}
