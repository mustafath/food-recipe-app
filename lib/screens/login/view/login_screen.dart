import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe_app/screens/main_menu/view/main_menu.dart';
import 'package:kartal/kartal.dart';

import 'package:food_recipe_app/extensions/colors.dart';
import 'package:food_recipe_app/screens/login/login_screen_constants.dart';
import 'package:food_recipe_app/screens/splash_screen/splash_screen.dart';

import '../../../componenets/app_text_field.dart';
import '../../../componenets/big_button.dart';
import '../../../componenets/social_media_button.dart';
import '../../../extensions/text_style.dart';
import '../../add_recipe/view/add_recipe.dart';
import '../export.dart';
import '../viewmodel/login_cubit.dart';
import '../widgets/enter_password_text.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
          emailController: emailController,
          formKey: formKey,
          passwordController: passwordController),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainMenu(),
              ),
            );
          }
        },
        builder: (context, state) {
          return buildScaffold();
        },
      ),
    );
  }
}

class buildScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        color: AppColors.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: Form(
              key: context.watch<LoginCubit>().formKey,
              child: Column(children: [
                HelloText().paddingTop(context.dynamicHeight(0.115)),
                WelcomeBackText().paddingTop(context.dynamicHeight(0.017)),
                EmailText().paddingTop(context.dynamicHeight(0.07)),
                EmailTextField(
                        emailController:
                            context.watch<LoginCubit>().emailController)
                    .paddingTop(5),
                EnterPasswordText().paddingTop(30),
                PasswordTextField(
                        passwordController:
                            context.watch<LoginCubit>().passwordController)
                    .paddingTop(5),
                ForgotPasswordText().paddingTop(20),
                context.watch<LoginCubit>().state is LoginLoading
                    ? (context.watch<LoginCubit>().state as LoginLoading)
                            .isLoading
                        ? SizedBox(
                            height: 60,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.accentColor,
                              ),
                            ),
                          ).paddingTop(25)
                        : SignInButton(onPressed: () async {
                            context.read<LoginCubit>().logIn(
                                email: context
                                    .read<LoginCubit>()
                                    .emailController
                                    .text,
                                password: context
                                    .read<LoginCubit>()
                                    .passwordController
                                    .text);
                          }).paddingTop(25)
                    : SignInButton(onPressed: () async {
                        context.read<LoginCubit>().logIn(
                            email:
                                context.read<LoginCubit>().emailController.text,
                            password: context
                                .read<LoginCubit>()
                                .passwordController
                                .text);
                      }).paddingTop(25),
                SignInWith().paddingTop(20),
                SocialMediaButtons().paddingTop(20),
                DontHaveAnAccount().paddingTop(55),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class SocialMediaButtons extends StatelessWidget {
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
        ),
      ],
    );
  }
}

class SignInWith extends StatelessWidget {
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

class SignInButton extends StatelessWidget {
  final void Function() onPressed;
  const SignInButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BigButton(
      buttonText: Constants.signIn,
      onPressed: onPressed,
    );
  }
}

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({
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

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
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

class EmailTextField extends StatelessWidget {
  const EmailTextField({
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

class EmailText extends StatelessWidget {
  const EmailText({
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
