import 'package:festivia/models/BannerMainHome.dart';
import 'package:festivia/models/HostEvent.dart';
import 'package:festivia/providers/auth_provider.dart';

import 'package:flutter/material.dart';

import '../../models/Ticket.dart';
import '../../providers/my_tickets_provider.dart';

class MyTicketsController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  List<BannerMainHome> list = List.empty();

  MyTicketsProvider _myTicketsProvider;
  AuthProvider _authProvider;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _myTicketsProvider = new MyTicketsProvider();
    _authProvider = new AuthProvider();
    refresh();
  }

  Future<List<Ticket>> getMyTickets() async {
    return await _myTicketsProvider.getMyTickets(_authProvider.getUser().uid);
  }
}
