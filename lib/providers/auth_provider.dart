import 'package:festivia/pages/forgotPassword/forgot_pass_controller.dart';
import 'package:festivia/responses/forgot_pass_response.dart';
import 'package:festivia/utils/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider {
  FirebaseAuth _firebaseAuth;
  SharedPref _sharedPref = new SharedPref();

  AuthProvider() {
    _firebaseAuth = FirebaseAuth.instance;
  }

  User getUser() {
    return _firebaseAuth.currentUser;
  }

  bool isSignedIn() {
    final currentUser = _firebaseAuth.currentUser;

    if (currentUser == null) {
      return false;
    }

    return true;
  }

  Future<bool> login(String email, String password) async {
    String errorMessage;

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      // CORREO INVALIDO
      // PASSWORD INCORRECTO
      // NO HAY CONEXION A INTERNET
      errorMessage = error.code;
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }

    return true;
  }

  Future<bool> register(String email, String password) async {
    String errorMessage;

    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      // CORREO INVALIDO
      // PASSWORD INCORRECTO
      // NO HAY CONEXION A INTERNET
      errorMessage = error.code;
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }

    return true;
  }

  Future<ForgotPassResponse> sendResetPasswordLink(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return ForgotPassResponse.ok;
    } on FirebaseAuthException catch (e) {
      return stringtToForgotPassResponse(e.code);
    }
  }

  Future<void> signOut() async {
    return Future.wait([_firebaseAuth.signOut()]);
  }

  Future<void> deleteAccount() async {
    await FirebaseAuth.instance.currentUser.delete();
  }
}
