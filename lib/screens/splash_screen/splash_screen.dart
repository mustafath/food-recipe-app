import 'package:flutter/material.dart';
import 'package:food_recipe_app/screens/login/login_screen.dart';
import 'package:kartal/kartal.dart';

import '../../componenets/medium_button.dart';
import '../../extensions/text_style.dart';

import 'splash_screen_constants.dart';

// Extensions for padding
extension PaddingExtension on Widget {
  Widget paddingTop(double value) {
    return Padding(
      padding: EdgeInsets.only(top: value),
      child: this,
    );
  }

  Widget paddingBottom(double value) {
    return Padding(
      padding: EdgeInsets.only(bottom: value),
      child: this,
    );
  }
}

/// SplashScreen widget displaying the splash screen.
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  void _handleStartCookingPressed(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => LoginScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _backgroundImage(),
          _linearGradientFromBottom(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _cookHat().paddingTop(context.dynamicHeight(0.13)),
                _PremiumRecipeText().paddingTop(context.dynamicHeight(0.017)),
                _getCookingText().paddingTop(context.dynamicHeight(0.27)),
                _simpleWayText().paddingTop(context.dynamicHeight(0.025)),
                MediumButton(
                  buttonText: Constants.start_cooking,
                  onPressed: () {
                    _handleStartCookingPressed(context);
                  },
                )
                    .paddingTop(context.dynamicHeight(0.078))
                    .paddingBottom(context.dynamicHeight(0.115)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Text _simpleWayText() =>
      Text(Constants.simple_way, style: AppTextStyles.normalTextRegular);

  Text _getCookingText() {
    return Text(
      Constants.get_cooking,
      style: AppTextStyles.headerTitle,
      textAlign: TextAlign.center,
    );
  }
}

class _PremiumRecipeText extends StatelessWidget {
  const _PremiumRecipeText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      Constants.premium_recipte,
      style: AppTextStyles.mediumTextBold,
    );
  }
}

class _cookHat extends StatelessWidget {
  const _cookHat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "lib/assets/cook_hat.png",
      width: 79,
      height: 79,
    );
  }
}

class _linearGradientFromBottom extends StatelessWidget {
  const _linearGradientFromBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(0, 0, 0, 0.4),
            Color.fromRGBO(0, 0, 0, 1),
          ],
        ),
      ),
    );
  }
}

class _backgroundImage extends StatelessWidget {
  const _backgroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.height,
      child: Image.asset(
        "lib/assets/splash_screen_bg.jpeg",
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
