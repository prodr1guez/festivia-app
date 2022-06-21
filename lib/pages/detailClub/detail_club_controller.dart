import 'package:festivia/models/Event.dart';
import 'package:festivia/providers/club_provider.dart';
import 'package:festivia/providers/event_provider.dart';
import 'package:flutter/material.dart';

import '../../models/Club.dart';

class DetailClubController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  ClubProvider _clubProvider = new ClubProvider();

  String idEvent;
  Club club;
  String dateParsed;
  String location;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    idEvent = ModalRoute.of(context).settings.arguments as String;
    print(idEvent + "-------");

    getClubInfo();
  }

  void getClubInfo() async {
    club = await _clubProvider.getById(idEvent);
    refresh();
  }
}
