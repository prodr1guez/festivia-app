import 'package:festivia/utils/shared_pref.dart';
import 'package:flutter/material.dart';

import '../add/add_page.dart';
import '../home_stats/home_stats_page.dart';
import '../myEvents/my_events_page.dart';
import '../myclubpage/my_club_page.dart';

class NavigationClubController {
  Function refresh;
  BuildContext context;
  SharedPref _sharedPref;

  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  final screensClub = [HomeStatsPage(), AddPage(), MyEvents(), MyClubPage()];

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    refresh();
  }
}
