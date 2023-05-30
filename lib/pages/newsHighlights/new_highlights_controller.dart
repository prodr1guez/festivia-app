import 'package:festivia/models/BannerMainHome.dart';
import 'package:festivia/models/HostEvent.dart';
import 'package:festivia/providers/auth_provider.dart';
import 'package:festivia/providers/club_provider.dart';
import 'package:festivia/providers/event_provider.dart';
import 'package:festivia/providers/new_provider.dart';

import 'package:flutter/material.dart';

import '../../models/Club.dart';
import '../../models/Event.dart';
import '../../models/News.dart';

class NewHightlightsController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  List<News> list = List.empty();

  NewProvider _newProvider;
  AuthProvider _authProvider;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _newProvider = new NewProvider();
    _authProvider = new AuthProvider();
    refresh();
  }

  Future<List<News>> getNews() async {
    List<News> listNews = await _newProvider.getNews();
    return listNews;
  }
}
