import 'package:festivia/models/Event.dart';
import 'package:festivia/providers/auth_provider.dart';
import 'package:festivia/providers/club_provider.dart';
import 'package:festivia/providers/event_provider.dart';
import 'package:flutter/material.dart';

import '../../models/Club.dart';
import '../../models/HostEvent.dart';

class MyClubController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  ClubProvider _clubProvider = new ClubProvider();
  AuthProvider _authProvider;

  String idEvent;
  Club club;
  String dateParsed;
  String location;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _authProvider = new AuthProvider();

    getClubInfo();
  }

  Future<List<HostEvent>> getMyEvents() async {
    return await _clubProvider.EventsClub(_authProvider.getUser().uid);
  }

  void getClubInfo() async {
    club = await _clubProvider.getById(_authProvider.getUser().uid);
    refresh();
  }

  navigateToContactClub(BuildContext context) {
    Navigator.pushNamed(context, 'contact_club_page');
  }

  navigateToEditPage(BuildContext context) {
    Navigator.pushNamed(context, 'edit_club_page', arguments: club);
  }

  Future<void> logout() async {
    await _authProvider.signOut();
    Navigator.pushNamed(context, 'start');
  }
}
