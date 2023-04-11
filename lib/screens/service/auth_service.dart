import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/user.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  static final AuthService instance = AuthService(FirebaseAuth.instance);

  LoggedInUserModel? loggedInUser;

  AuthService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<UserCredential?> signIn(
      {required String email, required String password}) async {
    try {
      UserCredential request = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return request;
    } on FirebaseAuthException catch (e) {
      debugPrint('Error: $e');
      throw e;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<UserCredential?> signUp(
      {required String email,
      required String password,
      required String name}) async {
    try {
      UserCredential request = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => value..user?.updateDisplayName(name));
      return request;
    } on FirebaseAuthException catch (e) {
      debugPrint('Error: $e');
      throw e;
    }
  }
}
