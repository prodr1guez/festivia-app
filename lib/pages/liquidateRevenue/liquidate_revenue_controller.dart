import 'package:festivia/models/User.dart';
import 'package:festivia/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:festivia/models/client.dart';
import 'package:festivia/providers/auth_provider.dart';
import 'package:festivia/providers/client_provider.dart';
import 'package:festivia/utils/my_progress_dialog.dart';
import 'package:festivia/utils/snackbar.dart' as utils;

import '../../providers/user_provider.dart';

class LiquidateRevenueController {
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  AuthProvider _authProvider;
  ClientProvider _clientProvider;
  UserProvider _userProvider;
  ProgressDialog _progressDialog;
  SharedPref _sharedPref;

  Future init(BuildContext context) async {
    this.context = context;
    _authProvider = new AuthProvider();
    _clientProvider = new ClientProvider();
    _userProvider = new UserProvider();
    _sharedPref = new SharedPref();
    _progressDialog =
        MyProgressDialog.createProgressDialog(context, 'Espere un momento...');
  }

  void register() async {
    String username = usernameController.text;
    String email = emailController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
    String password = passwordController.text.trim();

    print('Email: $email');
    print('Password: $password');

    if (username.isEmpty && email.isEmpty && password.isEmpty) {
      print('debes ingresar todos los campos');
      utils.Snackbar.showSnackbar(
          context, key, 'Debes ingresar todos los campos');
      return;
    }

    /*if (confirmPassword != password) {
      print('Las contraseñas no coinciden');
      utils.Snackbar.showSnackbar(context, key, 'Las contraseñas no coinciden');
      return;
    }*/

    if (password.length < 6) {
      print('el password debe tener al menos 6 caracteres');
      utils.Snackbar.showSnackbar(
          context, key, 'el password debe tener al menos 6 caracteres');
      return;
    }

    _progressDialog.show();

    try {
      bool isRegister = await _authProvider.register(email, password);
      String userId = _authProvider.getUser().uid;

      if (isRegister) {
        Client client = new Client(
            id: userId,
            email: _authProvider.getUser().email,
            username: username,
            password: password);

        await _clientProvider.create(client);
        await _userProvider.create(User(id: userId, type: "client"));
        await _sharedPref.save('typeUser', "client");

        _progressDialog.hide();
        Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);

        utils.Snackbar.showSnackbar(
            context, key, 'El usuario se registro correctamente');
        print('El usuario se registro correctamente');
      } else {
        _progressDialog.hide();
        print('El usuario no se pudo registrar');
      }
    } catch (error) {
      _progressDialog.hide();
      utils.Snackbar.showSnackbar(context, key, 'Error: $error');
      print('Error: $error');
    }
  }
}