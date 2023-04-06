import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe_app/screens/splash_screen/splash_screen.dart';
import 'package:food_recipe_app/utils/utils.dart';
import 'package:kartal/kartal.dart';

import '../../../componenets/app_text_field.dart';
import '../../../extensions/colors.dart';

import '../../../componenets/big_button.dart';
import '../../login/view/login_screen.dart';
import '../viewmodel/signup_cubit.dart';
import '../signup_screen_constants.dart';

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
        passwordAgainController: passwordAgainController,
      ),
      child: SignupScaffold(),
    );
  }
}

class SignupScaffold extends StatelessWidget {
  const SignupScaffold({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: AppColors.backgroundColor,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              _buildSubheader(context),
              _buildForm(context),
              _buildTerms(context),
              _buildSignupButton(context),
              _buildErrorText(context),
              SignInWith().paddingTop(20),
              SocialMediaButtons().paddingTop(20),
              buildSignInLink(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Text(
          Constants.createAccount,
          style: AppTextStyles.largeTextBold,
        ).paddingTop(context.dynamicHeight(0.115)),
        Spacer(),
      ],
    );
  }

  Widget _buildSubheader(BuildContext context) {
    return Row(
      children: [
        Text(
          Constants.helpYouSetAccount,
          style: AppTextStyles.smallerTextRegular,
        ).paddingTop(context.dynamicHeight(0.017)),
        Spacer(),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Constants.name, style: AppTextStyles.smallTextRegular)
            .paddingTop(20),
        AppTextField(
          hintText: Constants.enterName,
          controller: context.read<SignupCubit>().nameController,
        ).paddingTop(5),
        Text(Constants.email, style: AppTextStyles.smallTextRegular)
            .paddingTop(20),
        AppTextField(
          hintText: Constants.enterEmail,
          controller: context.read<SignupCubit>().emailController,
        ).paddingTop(5),
        Text(Constants.password, style: AppTextStyles.smallTextRegular)
            .paddingTop(20),
        AppTextField(
          obscureText: true,
          hintText: Constants.enterPassword,
          controller: context.read<SignupCubit>().passwordController,
        ).paddingTop(5),
        Text(Constants.confirmPassword, style: AppTextStyles.smallTextRegular)
            .paddingTop(20),
        AppTextField(
          obscureText: true,
          hintText: Constants.retypePassword,
          controller: context.read<SignupCubit>().passwordAgainController,
        ).paddingTop(5),
      ],
    );
  }

  Widget _buildTerms(BuildContext context) {
    return Text(
      Constants.acceptTerms,
      style:
          AppTextStyles.smallerTextRegular.copyWith(color: AppColors.linkColor),
    ).paddingTop(20);
  }

  Widget _buildSignupButton(BuildContext context) {
    final signupCubit = context.watch<SignupCubit>();

    if (signupCubit.state is SignupLoading &&
        (signupCubit.state as SignupLoading).isLoading) {
      return SizedBox(
        height: 60,
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.accentColor,
          ),
        ),
      );
    }

    return BigButton(
      onPressed: () {
        context.read<SignupCubit>().signUp(
              name: context.read<SignupCubit>().nameController.text,
              email: context.read<SignupCubit>().emailController.text,
              password: context.read<SignupCubit>().passwordController.text,
            );
      },
      buttonText: Constants.signUp,
    );
  }

  Widget _buildErrorText(BuildContext context) {
    final signupCubit = context.watch<SignupCubit>();
    if (signupCubit.state is SignupFailure) {
      final error = (signupCubit.state as SignupFailure).message;
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          "Error: ${error}",
          style: TextStyle(
            color: Colors.red,
            fontSize: 14,
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget buildSignInLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Constants.alreadyMember,
          style: AppTextStyles.smallerTextRegular,
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => LoginScreen()),
            );
          },
          child: Text(
            Constants.signIn,
            style: AppTextStyles.smallerTextRegular
                .copyWith(color: AppColors.linkColor),
          ),
        ),
      ],
    ).paddingTop(20);
  }
}
