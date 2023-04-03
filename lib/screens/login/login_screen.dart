import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:food_recipe_app/extensions/colors.dart';

import 'package:food_recipe_app/screens/login/login_screen_constants.dart';
import 'package:food_recipe_app/screens/splash_screen/splash_screen.dart';
import 'package:kartal/kartal.dart';

import '../../componenets/app_text_field.dart';
import '../../componenets/big_button.dart';
import '../../componenets/social_media_button.dart';
import '../../extensions/text_style.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBody(),
    );
  }
}

class LoginBody extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Center(
          child: Column(children: [
            helloText().paddingTop(context.dynamicHeight(0.115)),
            welcomeBackText().paddingTop(context.dynamicHeight(0.017)),
            emailText().paddingTop(context.dynamicHeight(0.07)),
            emailTextField(emailController: emailController).paddingTop(5),
            enterPasswordText().paddingTop(30),
            passwordTextField(passwordController: passwordController)
                .paddingTop(5),
            forgotPasswordText().paddingTop(20),
            signInButton().paddingTop(25),
            signInWith().paddingTop(20),
            socialMediaButtons().paddingTop(20),
            dontHaveAnAccount().paddingTop(55),
          ]),
        ),
      ),
    );
  }
}

class enterPasswordText extends StatelessWidget {
  const enterPasswordText({
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

class dontHaveAnAccount extends StatelessWidget {
  const dontHaveAnAccount({
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
          onPressed: () {},
        )
      ],
    );
  }
}

class socialMediaButtons extends StatelessWidget {
  const socialMediaButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialMediaButton(
          iconPath: "lib/assets/google.jpeg",
          onPressed: () {},
        ),
        SizedBox(
          width: 25,
        ),
        SocialMediaButton(
          iconPath: "lib/assets/fb.png",
          onPressed: () {},
        )
      ],
    );
  }
}

class signInWith extends StatelessWidget {
  const signInWith({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50,
          child: Divider(
            height: 1,
            color: AppColors.secondaryTextColor,
          ),
        ),
        SizedBox(
          width: 7,
        ),
        Text(
          Constants.singInWith,
          style: AppTextStyles.smallerTextSemiBold
              .copyWith(color: AppColors.secondaryTextColor),
        ),
        SizedBox(
          width: 7,
        ),
        Container(
          width: 50,
          child: Divider(
            height: 1,
            color: AppColors.secondaryTextColor,
          ),
        ),
      ],
    );
  }
}

class signInButton extends StatelessWidget {
  const signInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BigButton(
      buttonText: Constants.signIn,
      onPressed: () {},
    );
  }
}

class forgotPasswordText extends StatelessWidget {
  const forgotPasswordText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(Constants.forgotPassword,
            style: AppTextStyles.smallerTextRegular
                .copyWith(color: AppColors.linkColor)),
        Spacer()
      ],
    );
  }
}

class passwordTextField extends StatelessWidget {
  const passwordTextField({
    super.key,
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: passwordController,
      hintText: Constants.enterPassword,
      obscureText: true,
    );
  }
}

class emailTextField extends StatelessWidget {
  const emailTextField({
    super.key,
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: emailController,
      hintText: Constants.enterEmail,
      obscureText: false,
    );
  }
}

class emailText extends StatelessWidget {
  const emailText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          Constants.email,
          style: AppTextStyles.smallTextRegular
              .copyWith(color: AppColors.blackColor),
        ),
        Spacer()
      ],
    );
  }
}

class welcomeBackText extends StatelessWidget {
  const welcomeBackText({
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

class helloText extends StatelessWidget {
  const helloText({
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
