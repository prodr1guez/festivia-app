import 'package:festivia/pages/add/add_page.dart';
import 'package:festivia/pages/home/home_page.dart';
import 'package:festivia/pages/myTickets/my_tickets_page.dart';
import 'package:festivia/pages/navigation/%20navigation_controller.dart';
import 'package:festivia/pages/profile/profile_page.dart';
import 'package:festivia/pages/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/scheduler.dart';
import 'package:festivia/utils/colors.dart' as utils;

import '../addArtist/add_artist_page.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  NavigationController _controller = new NavigationController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.init(context, refresh);
    });
  }

  int index = 0;
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  final screens = [
    HomePage(),
    SearchPage(),
    AddPage(),
    //AddArtist(),
    MyTickets(),
    ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(
        Icons.home,
        color: Colors.white,
        size: 30,
      ),
      Icon(
        Icons.search_rounded,
        color: Colors.white,
        size: 30,
      ),
      Icon(
        Icons.add,
        color: Colors.white,
        size: 30,
      ),
      Icon(
        Icons.event_available_rounded,
        color: Colors.white,
        size: 30,
      ),
      Icon(
        Icons.person,
        color: Colors.white,
        size: 30,
      ),
    ];
    return Scaffold(
      extendBody: true,
      body: Container(child: SafeArea(child: screens[index], bottom: false)),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.black,
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
