import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupCubit extends Cubit<SignupState> {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordAgainController;

  SignupCubit(
      {required this.passwordAgainController,
      required this.formKey,
      required this.nameController,
      required this.emailController,
      required this.passwordController})
      : super(SignupInitial());
}
