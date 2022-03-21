import 'package:festivia/models/BannerMainHome.dart';
import 'package:festivia/models/HostEvent.dart';
import 'package:festivia/providers/auth_provider.dart';
import 'package:festivia/providers/my_events_provider.dart';
import 'package:flutter/material.dart';

class MyEventController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  List<BannerMainHome> list = List.empty();

  MyEventsProvider _myEventsProvider;
  AuthProvider _authProvider;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _myEventsProvider = new MyEventsProvider();
    _authProvider = new AuthProvider();
    refresh();
  }

  Future<List<HostEvent>> getMyEvents() async {
    return await _myEventsProvider.getMyEvents(_authProvider.getUser().uid);
  }
}
