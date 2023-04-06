import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../service/auth_service.dart';

abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupCubit extends Cubit<SignupState> {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordAgainController;
  bool isLoading = false;

  SignupCubit({
    required this.passwordAgainController,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  }) : super(SignupInitial());

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      setLoadingState(true);
      await AuthService.instance
          .signUp(email: email, password: password, name: name)
          .then((value) {
        print(value?.user?.uid);

        emit(SignupSuccess(user: value?.user));
      });
      setLoadingState(false);
    } catch (e) {
      print(e.runtimeType);
      setLoadingState(false);
      String errorMessage = "";
      if (e.runtimeType == FirebaseAuthException) {
        errorMessage = _getErrorMessage((e as FirebaseAuthException).code);
      }
      emit(SignupFailure(exception: e, message: errorMessage));
    }
  }

  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'email-already-in-use':
        return "This email address is already in use.";
      case 'invalid-email':
        return "Invalid email address.";
      case 'operation-not-allowed':
        return "Operation not allowed.";
      case 'weak-password':
        return "The password is too weak.";
      case 'user-disabled':
        return "The user has been disabled.";
      case 'user-not-found':
        return "User not found.";
      case 'wrong-password':
        return "Incorrect password.";
      case 'too-many-requests':
        return "Too many requests. Please try again later.";
      default:
        return "An error occurred. Please try again.";
    }
  }

  void setLoadingState(bool state) {
    emit(SignupLoading(state));
  }
}

class SignupSuccess extends SignupState {
  final User? user;

  SignupSuccess({required this.user});
}

class SignupFailure extends SignupState {
  final Object exception;
  final String message;

  SignupFailure({required this.exception, required this.message});
}

class SignupLoading extends SignupState {
  final bool isLoading;

  SignupLoading(this.isLoading);
}
