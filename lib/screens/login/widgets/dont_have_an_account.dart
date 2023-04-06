import 'package:flutter/material.dart';

import '../../../extensions/colors.dart';
import '../../../extensions/text_style.dart';
import '../../signup/view/signup_screen.dart';
import '../login_screen_constants.dart';

class DontHaveAnAccount extends StatelessWidget {
  const DontHaveAnAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Constants.dontHaveAnAccount,
          style: AppTextStyles.smallerTextSemiBold,
        ),
        TextButton(
          child: Text(
            Constants.signUp,
            style: AppTextStyles.smallerTextSemiBold
                .copyWith(color: AppColors.linkColor),
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => SignupScreen()));
          },
        )
      ],
    );
  }
}
