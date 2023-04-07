import 'package:flutter/material.dart';
import "dart:io";

extension XPadding on Widget {
  Widget paddingTop(double value) {
    return Padding(
      padding: EdgeInsets.only(top: value),
      child: this,
    );
  }
}
