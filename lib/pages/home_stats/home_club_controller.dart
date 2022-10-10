import 'package:festivia/models/Event.dart';
import 'package:festivia/providers/auth_provider.dart';
import 'package:festivia/providers/club_provider.dart';
import 'package:festivia/providers/event_provider.dart';
import 'package:flutter/material.dart';

import '../../models/Club.dart';
import '../../models/HostEvent.dart';

class HomeClubController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  ClubProvider _clubProvider = new ClubProvider();
  AuthProvider _authProvider;

  String idEvent;
  Club club = Club(
      revenueYear: 0,
      ticketsYear: 0,
      ticketsNextEvents: 0,
      nextEvents: 0,
      currentRevenue: 0);
  String dateParsed;
  String location;
  int nextEvents = 0;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _authProvider = new AuthProvider();

    getMyEvents();
    getClubInfo();
  }

  Future<List<HostEvent>> getMyEvents() async {
    List<HostEvent> events =
        await _clubProvider.getNextEventsClub(_authProvider.getUser().uid);

    nextEvents = events.length;
  }

  void getClubInfo() async {
    club = await _clubProvider.getById(_authProvider.getUser().uid);
    refresh();
  }

  navigateToLiquidateRevenue(BuildContext context) {
    Navigator.pushNamed(context, 'liquidate_revenue');
  }

  navigateToContactUs(BuildContext context) {
    Navigator.pushNamed(context, 'contact_us');
  }

  Future<void> logout() async {
    await _authProvider.signOut();
    Navigator.pushNamed(context, 'start');
  }
}
