import 'package:festivia/models/Club.dart';
import 'package:festivia/models/GlobalData.dart';
import 'package:festivia/models/Invoice.dart';
import 'package:festivia/models/User.dart';
import 'package:festivia/providers/club_provider.dart';
import 'package:festivia/providers/event_provider.dart';
import 'package:festivia/providers/global_data_provider.dart';
import 'package:festivia/providers/liquidate_provider.dart';
import 'package:festivia/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:min_id/min_id.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:festivia/models/client.dart';
import 'package:festivia/providers/auth_provider.dart';
import 'package:festivia/providers/client_provider.dart';
import 'package:festivia/utils/my_progress_dialog.dart';
import 'package:festivia/utils/snackbar.dart' as utils;

import '../../models/Ticket.dart';
import '../../providers/user_provider.dart';

class GuestsController {
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  AuthProvider _authProvider;
  EventProvider _eventProvider;
  ProgressDialog _progressDialog;
  double revenue = 0;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    _authProvider = AuthProvider();
    refresh();
  }

  navigateToAddGuest(BuildContext context, String idEvent) {
    Navigator.pushNamed(context, 'add_guest', arguments: {"idEvent": idEvent});
  }

  getGuestSnapshot(String id) {
    _eventProvider = EventProvider();
    return _eventProvider.getGuestSnapshot(id);
  }
}
