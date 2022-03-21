import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:festivia/models/client.dart';
import 'package:festivia/providers/auth_provider.dart';
import 'package:festivia/providers/client_provider.dart';
import 'package:festivia/utils/my_progress_dialog.dart';
import 'package:festivia/utils/snackbar.dart' as utils;

class LoginController {
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  AuthProvider _authProvider;
  ProgressDialog _progressDialog;
  ClientProvider _clientProvider;

  String _typeUser;

  Future init(BuildContext context) async {
    this.context = context;
    _authProvider = new AuthProvider();
    _clientProvider = new ClientProvider();
    _progressDialog =
        MyProgressDialog.createProgressDialog(context, 'Espere un momento...');
  }

  void goToRegisterPage() {
    if (_typeUser == 'client') {
      Navigator.pushNamed(context, 'client/register');
    } else {
      Navigator.pushNamed(context, 'driver/register');
    }
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    print('Email: $email');
    print('Password: $password');

    try {
      bool isLogin = await _authProvider.login(email, password);

      if (isLogin) {
        print('El usuario esta logeado');

        Client client =
            await _clientProvider.getById(_authProvider.getUser().uid);
        print('CLIENT: $client');

        if (client != null) {
          print('El cliente no es nulo');
          Navigator.pushNamedAndRemoveUntil(
              context, 'navigation', (route) => false);
        } else {
          print('El cliente si es nulo');
          utils.Snackbar.showSnackbar(context, key, 'El usuario no es valido');
          await _authProvider.signOut();
        }
      } else {
        utils.Snackbar.showSnackbar(
            context, key, 'El usuario no se pudo autenticar');
        print('El usuario no se pudo autenticar');
      }
    } catch (error) {
      utils.Snackbar.showSnackbar(context, key, 'Error: $error');
      _progressDialog.hide();
      print('Error: $error');
    }
  }
}
