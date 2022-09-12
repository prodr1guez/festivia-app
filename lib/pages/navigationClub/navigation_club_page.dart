import 'package:festivia/pages/add/add_page.dart';
import 'package:festivia/pages/home_stats/home_stats_page.dart';
import 'package:festivia/pages/myEvents/my_events_page.dart';
import 'package:festivia/pages/myclubpage/my_club_page.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/scheduler.dart';

import 'navigation_club_controller.dart';

class NavigationClubPage extends StatefulWidget {
  @override
  _NavigationClubPageState createState() => _NavigationClubPageState();
}

class _NavigationClubPageState extends State<NavigationClubPage> {
  NavigationClubController _controller = new NavigationClubController();
  int index = 0;
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  final screens = [HomeStatsPage(), AddPage(), MyEvents(), MyClubPage()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
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
    return Scaffold(
      extendBody: true,
      body: Container(child: SafeArea(child: screens[index], bottom: false)),
      bottomNavigationBar: CurvedNavigationBar(
        key: navigationKey,
        items: items,
        height: 60,
        index: index,
        backgroundColor: Colors.transparent.withOpacity(0.0),
        onTap: (index) => setState(() => this.index = index),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
