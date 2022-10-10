import 'package:flutter/material.dart';

import '../providers/auth_provider.dart';
import '../utils/shared_pref.dart';

class StartController {
  BuildContext context;
  SharedPref _sharedPref;

  AuthProvider _authProvider;
  String _typeUser;
  bool laoding = true;
  Function refresh;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    _sharedPref = SharedPref();
    _authProvider = AuthProvider();
    _typeUser = await _sharedPref.read('typeUser');
    this.refresh = refresh;
    checkIfUserIsAuth();
  }

  void checkIfUserIsAuth() {
    bool isSigned = _authProvider.isSignedIn();
    if (isSigned) {
      laoding = false;

      if (_typeUser == 'client') {
        Navigator.pushNamedAndRemoveUntil(
            context, 'navigation', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, 'navigation_club', (route) => false);
      }
    } else {
      laoding = false;
      refresh();
    }
  }
}
