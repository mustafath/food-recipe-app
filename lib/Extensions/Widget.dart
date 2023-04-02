import 'package:flutter/material.dart';
import "dart:io";

extension on Widget {
  Widget paddingTop(double value) {
    return Padding(
      padding: EdgeInsets.only(top: value),
      child: this,
    );
  }
}
