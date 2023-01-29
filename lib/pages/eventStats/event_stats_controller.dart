import 'package:festivia/models/Event.dart';
import 'package:festivia/models/User.dart';
import 'package:festivia/pages/guests/guests_page.dart';
import 'package:festivia/providers/auth_provider.dart';
import 'package:festivia/providers/client_provider.dart';
import 'package:festivia/providers/event_provider.dart';
import 'package:festivia/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../models/Ticket.dart';
import '../../models/client.dart';
import '../../utils/my_progress_dialog.dart';

class EventStatsController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  EventProvider _eventProvider = new EventProvider();
  ProgressDialog _progressDialog;
  AuthProvider _authProvider = AuthProvider();
  UserProvider _userProvider = UserProvider();

  String idEvent;
  Event event = Event(
      tittle: "",
      assistants: 0,
      generalTicketsSold: 0,
      freeTicketsSold: 0,
      vipTicketsSold: 0,
      revenue: 0.0);
  String dateParsed;
  String location;
  User user;
  bool showLiquidate = false;
  int checksIn = 0;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _progressDialog =
        MyProgressDialog.createProgressDialog(context, 'Espere un momento...');
    idEvent = ModalRoute.of(context).settings.arguments as String;

    user = await _userProvider.getById(_authProvider.getUser().uid);

    if (user != null && user.type == "client") {
      showLiquidate = true;
    }

    getEventInfo();
  }

  void getEventInfo() async {
    await _progressDialog.show();
    event = await _eventProvider.getById(idEvent);

    List<Ticket> tickets = await _eventProvider.getTicketsEvents(idEvent);
    var checksin = 0;

    for (var ticket in tickets) {
      if (ticket.checkedIn) {
        checksin++;
      }
    }
    await _progressDialog.hide();
    checksIn = checksin;
    refresh();
  }

  navigateToGuests(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return GuestsPage(idEvent: idEvent);
    }));
  }

  navigateToLiquidateRevenue(BuildContext context) {
    Navigator.pushNamed(context, 'liquidate_revenue',
        arguments: {"idEvent": idEvent});
  }
}
