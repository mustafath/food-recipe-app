// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:food_recipe_app/screens/service/auth_service.dart';

enum FirebaseAuthExceptions {
  emailAlreadyInUse,
  invalidEmail,
  operationNotAllowed,
  weakPassword,
  userDisabled,
  userNotFound,
  wrongPassword,
  tooManyRequests,
  undefined
}

class FirebaseAuthException implements Exception {
  final FirebaseAuthExceptions code;
  final String message;

  FirebaseAuthException(this.code, this.message);
}

class LoginCubit extends Cubit<LoginState> {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  bool isLoading = false;

  LoginCubit({
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  }) : super(LoginInitial());

  Future<void> logIn({required String email, required String password}) async {
    setLoadingState(true);
    try {
      await AuthService.instance
          .signIn(email: email, password: password)
          .then((value) {
        print(value?.user?.uid);
        setLoadingState(false);
        emit(LoginSuccess(user: value?.user));
      });
    } catch (e) {
      setLoadingState(false);
      if (e is FirebaseAuthException) emit(LoginFailure(e));
    }
  }

  void setLoadingState(bool state) {
    emit(LoginLoading(state));
  }
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {
  final bool isLoading;

  LoginLoading(this.isLoading);
}

class LoginSuccess extends LoginState {
  final User? user;

  LoginSuccess({required this.user});
}

class LoginFailure extends LoginState {
  final FirebaseAuthException exception;

  LoginFailure(this.exception);
}
