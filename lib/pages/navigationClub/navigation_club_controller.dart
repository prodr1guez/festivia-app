import 'package:festivia/utils/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../add/add_page.dart';
import '../home/home_page.dart';
import '../home_stats/home_stats_page.dart';
import '../myEvents/my_events_page.dart';
import '../myTickets/my_tickets_page.dart';
import '../myclubpage/my_club_page.dart';
import '../profile/profile_page.dart';
import '../search/search_page.dart';

class NavigationClubController {
  Function refresh;
  BuildContext context;
  SharedPref _sharedPref;

  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  final itemsClubs = <Widget>[
    Icon(
      Icons.home,
      size: 30,
    ),
    Icon(
      Icons.add,
      size: 30,
    ),
    Icon(
      Icons.event_available_rounded,
      size: 30,
    ),
    Icon(
      Icons.person,
      size: 30,
    ),
  ];

  final itemsClient = <Widget>[
    Icon(
      Icons.home,
      size: 30,
    ),
    Icon(
      Icons.search_rounded,
      size: 30,
    ),
    Icon(
      Icons.add,
      size: 30,
    ),
    Icon(
      Icons.event_available_rounded,
      size: 30,
    ),
    Icon(
      Icons.person,
      size: 30,
    ),
  ];
  var arguments;
  int index = null;
  final screensClub = [HomeStatsPage(), AddPage(), MyEvents(), MyClubPage()];
  final screensClient = [
    HomePage(),
    SearchPage(),
    AddPage(),
    //AddArtist(),
    MyTickets(),
    ProfilePage()
  ];

  var screens = [];
  var items = [];

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _sharedPref = new SharedPref();
    arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) {
      index = arguments["index"];
    }

    var typeUser = await _sharedPref.read("typeUser");

    if (typeUser.toString().contains("client")) {
      print("llegando");
      screens = screensClient;
      items = itemsClient;
    } else {
      print("llegando2");
      screens = screensClub;
      items = itemsClubs;
    }

    refresh();
  }
}
