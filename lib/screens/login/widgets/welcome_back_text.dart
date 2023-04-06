import 'package:flutter/material.dart';

import '../../../extensions/text_style.dart';
import '../login_screen_constants.dart';

class WelcomeBackText extends StatelessWidget {
  const WelcomeBackText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(Constants.welcomeBack,
            style:
                AppTextStyles.largeTextRegular.copyWith(color: Colors.black)),
        Spacer(),
      ],
    );
  }
}
