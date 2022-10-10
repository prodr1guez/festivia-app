import 'package:festivia/models/User.dart';
import 'package:festivia/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:festivia/models/client.dart';
import 'package:festivia/providers/auth_provider.dart';
import 'package:festivia/providers/client_provider.dart';
import 'package:festivia/utils/my_progress_dialog.dart';
import 'package:festivia/utils/snackbar.dart' as utils;

import '../../utils/shared_pref.dart';

class LoginController {
  BuildContext context;
  Function refresh;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  AuthProvider _authProvider;
  ProgressDialog _progressDialog;
  ClientProvider _clientProvider;
  UserProvider _userProvider;
  SharedPref _sharedPref;

  String _typeUser;

  Future init(BuildContext context, Function refresh) async {
    this.refresh = refresh;
    this.context = context;
    _authProvider = new AuthProvider();
    _clientProvider = new ClientProvider();
    _userProvider = new UserProvider();
    _sharedPref = new SharedPref();
    _progressDialog =
        MyProgressDialog.createProgressDialog(context, 'Espere un momento...');
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      utils.Snackbar.showSnackbar(
          context, key, 'Debe completar todos los campos');
      return;
    }

    _progressDialog.show();

    try {
      bool isLogin = await _authProvider.login(email, password);

      if (isLogin) {
        User client = await _userProvider.getById(_authProvider.getUser().uid);

        if (client != null) {
          if (client.type.contains("client")) {
            _progressDialog.hide();
            await _sharedPref.save("typeUser", "client");
            Navigator.pushNamedAndRemoveUntil(
                context, 'navigation', (route) => false);
          } else {
            _progressDialog.hide();

            await _sharedPref.save("typeUser", "club");
            Navigator.pushNamedAndRemoveUntil(
                context, 'navigation_club', (route) => false);
          }
        } else {
          _progressDialog.hide();
          utils.Snackbar.showSnackbar(context, key, 'El usuario no es valido');
          await _authProvider.signOut();
        }
      } else {
        _progressDialog.hide();
        utils.Snackbar.showSnackbar(
            context, key, 'El usuario no se pudo autenticar');
      }
    } catch (error) {
      utils.Snackbar.showSnackbar(context, key, 'Error: $error');
      _progressDialog.hide();

      utils.Snackbar.showSnackbar(context, key, 'Error: $error');
    }
  }

  navigateToForgotPass(BuildContext context) {
    Navigator.pushNamed(context, 'forgot_pass');
  }
}
