import 'package:festivia/models/BannerMainHome.dart';
import 'package:festivia/models/HostEvent.dart';
import 'package:festivia/providers/auth_provider.dart';
import 'package:festivia/providers/club_provider.dart';
import 'package:festivia/providers/event_provider.dart';

import 'package:flutter/material.dart';

import '../../models/Club.dart';
import '../../models/Event.dart';

class ClubHightlightsController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  List<BannerMainHome> list = List.empty();

  ClubProvider _clubProvider;
  AuthProvider _authProvider;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _clubProvider = new ClubProvider();
    _authProvider = new AuthProvider();
    refresh();
  }

  Future<List<Club>> getClubs() async {
    List<Club> listClubs = await _clubProvider.getClubs();
    listClubs.shuffle();
    return listClubs;
  }
}
