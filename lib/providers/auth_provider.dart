import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider {
  FirebaseAuth _firebaseAuth;

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

  void checkIfUserIsLogged(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User user) async {
      if (user != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, 'navigation', (route) => false);

        print('El usuario esta logeado1');
      } else {
        print('El usuario no esta logeado');
      }
    });
  }

  Future<bool> login(String email, String password) async {
    String errorMessage;

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
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
