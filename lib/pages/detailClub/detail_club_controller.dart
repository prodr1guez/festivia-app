import 'package:festivia/models/Event.dart';
import 'package:festivia/providers/club_provider.dart';
import 'package:festivia/providers/event_provider.dart';
import 'package:flutter/material.dart';

import '../../models/Club.dart';
import '../../models/HostEvent.dart';

class DetailClubController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  ClubProvider _clubProvider = new ClubProvider();

  String idClub;
  Club club;
  String dateParsed;
  String location;
  List<HostEvent> listEvent;

  Future init(BuildContext context, Function refresh, String id) async {
    this.context = context;
    this.refresh = refresh;
    idClub = id;
    getClubInfo();
  }

  // CORREGIR
  Future<List<HostEvent>> getMyEvents() async {
    return await _clubProvider.EventsClub(idClub);
  }

  Future<List<HostEvent>> getEventsClub() async {
    if (listEvent == null) {
      return await _clubProvider.EventsForClub(idClub);
    }
    return listEvent;
  }

  void getClubInfo() async {
    club = await _clubProvider.getById(idClub);
    refresh();
  }

  navigateToContactClub(BuildContext context) {
    Navigator.pushNamed(context, 'contact_club_page');
  }

  navigateToMapPage(BuildContext context) {
    Navigator.pushNamed(context, 'map_page');
  }
}
