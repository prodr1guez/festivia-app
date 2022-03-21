import 'package:festivia/pages/add/add_page.dart';
import 'package:festivia/pages/favourite/favourite_page.dart';
import 'package:festivia/pages/home/home_page.dart';
import 'package:festivia/pages/profile/profile_page.dart';
import 'package:festivia/pages/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int index = 0;
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  final screens = [
    HomePage(),
    SearchPage(),
    AddPage(),
    FavouritePage(),
    ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(
        Icons.home,
        size: 30,
      ),
      Icon(
        Icons.search,
        size: 30,
      ),
      Icon(
        Icons.add,
        size: 30,
      ),
      Icon(
        Icons.favorite,
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
}
