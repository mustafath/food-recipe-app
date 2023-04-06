import 'package:flutter/material.dart';

import '../../../extensions/text_style.dart';
import '../login_screen_constants.dart';

class HelloText extends StatelessWidget {
  const HelloText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          Constants.hello,
          style: AppTextStyles.headerTextBold.copyWith(color: Colors.black),
        ),
        Spacer()
      ],
    );
  }
}
