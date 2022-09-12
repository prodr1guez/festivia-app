import 'package:festivia/providers/auth_provider.dart';
import 'package:festivia/responses/forgot_pass_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../utils/my_progress_dialog.dart';

class ForgotPassController extends SimpleNotifier {
  String _email = "";
  String get email => _email;
  AuthProvider _authProvider = new AuthProvider();
  BuildContext context;
  Function refresh;
  ProgressDialog progressDialog;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  Future init(BuildContext context, Function refresh) async {
    this.refresh = refresh;
    this.context = context;
    _authProvider = new AuthProvider();
    progressDialog =
        MyProgressDialog.createProgressDialog(context, 'Espere un momento...');
  }

  void onEmailChanged(String text) {
    _email = text;
  }

  Future<ForgotPassResponse> submit() {
    return _authProvider.sendResetPasswordLink(email);
  }
}
