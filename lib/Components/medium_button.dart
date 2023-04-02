import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';

class MediumButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const MediumButton(
      {Key? key, required this.onPressed, required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 243,
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFF129575),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          elevation: MaterialStateProperty.all<double>(0),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
