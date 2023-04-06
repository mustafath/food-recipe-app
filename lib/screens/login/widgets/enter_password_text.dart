import "package:flutter/material.dart";
import "package:food_recipe_app/utils/utils.dart";

import "../login_screen_constants.dart";

class EnterPasswordText extends StatelessWidget {
  const EnterPasswordText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          Constants.enterPassword,
          style: AppTextStyles.smallTextRegular,
        ),
        Spacer()
      ],
    );
  }
}
