import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe_app/componenets/app_text_field.dart';
import 'package:food_recipe_app/componenets/big_button.dart';
import 'package:food_recipe_app/extensions/text_style.dart';
import 'package:food_recipe_app/screens/login/view/login_screen.dart';
import 'package:food_recipe_app/screens/service/auth_service.dart';
import 'package:food_recipe_app/screens/signup/signup_screen_constants.dart';
import 'package:food_recipe_app/screens/splash_screen/splash_screen.dart';
import 'package:kartal/kartal.dart';

import '../../../Extensions/Colors.dart';
import '../viewmodel/signup_cubit.dart';

class SignupScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordAgainController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(
          emailController: emailController,
          formKey: formKey,
          nameController: nameController,
          passwordController: passwordController,
          passwordAgainController: passwordAgainController),
      child: buildScaffold(),
    );
  }
}

class buildScaffold extends StatelessWidget {
  const buildScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: AppColors.backgroundColor,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    Constants.createAccount,
                    style: AppTextStyles.largeTextBold,
                  ).paddingTop(context.dynamicHeight(0.115)),
                  Spacer()
                ],
              ),
              Row(
                children: [
                  Text(Constants.helpYouSetAccount,
                          style: AppTextStyles.smallerTextRegular)
                      .paddingTop(context.dynamicHeight(0.017)),
                  Spacer()
                ],
              ),
              Text(Constants.name, style: AppTextStyles.smallTextRegular)
                  .paddingTop(20),
              AppTextField(
                      hintText: Constants.enterName,
                      controller: context.read<SignupCubit>().nameController)
                  .paddingTop(5),
              Text(Constants.email, style: AppTextStyles.smallTextRegular)
                  .paddingTop(20),
              AppTextField(
                      hintText: Constants.enterEmail,
                      controller: context.read<SignupCubit>().emailController)
                  .paddingTop(5),
              Text(Constants.password, style: AppTextStyles.smallTextRegular)
                  .paddingTop(20),
              AppTextField(
                      obscureText: true,
                      hintText: Constants.enterPassword,
                      controller:
                          context.read<SignupCubit>().passwordController)
                  .paddingTop(5),
              Text(Constants.confirmPassword,
                      style: AppTextStyles.smallTextRegular)
                  .paddingTop(20),
              AppTextField(
                      obscureText: true,
                      hintText: Constants.retypePassword,
                      controller:
                          context.read<SignupCubit>().passwordAgainController)
                  .paddingTop(5),
              Text(Constants.acceptTerms,
                      style: AppTextStyles.smallerTextRegular
                          .copyWith(color: AppColors.linkColor))
                  .paddingTop(20),
              BigButton(
                  onPressed: () {
                    AuthService.instance.signUp(
                        name: context.read<SignupCubit>().nameController.text,
                        email: context.read<SignupCubit>().emailController.text,
                        password: context
                            .read<SignupCubit>()
                            .passwordController
                            .text);
                  },
                  buttonText: Constants.signUp),
              SignInWith().paddingTop(20),
              SocialMediaButtons().paddingTop(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Constants.alreadyMember,
                    style: AppTextStyles.smallerTextRegular,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => LoginScreen()));
                      },
                      child: Text(
                        Constants.signIn,
                        style: AppTextStyles.smallerTextRegular
                            .copyWith(color: AppColors.linkColor),
                      ))
                ],
              ).paddingTop(20)
            ],
          ),
        ),
      ),
    );
  }
}
