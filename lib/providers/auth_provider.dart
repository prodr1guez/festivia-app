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
      print("paso 2.1");
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      print("paso 2.2");
    } catch (error) {
      print(error);
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
      print(error);
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

  Future<void> signOut() async {
    return Future.wait([_firebaseAuth.signOut()]);
  }
}
