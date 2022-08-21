import 'package:festivia/models/BannerMainHome.dart';
import 'package:festivia/models/HostEvent.dart';
import 'package:festivia/providers/auth_provider.dart';
import 'package:festivia/providers/event_provider.dart';

import 'package:flutter/material.dart';

import '../../models/Event.dart';

class EventHightlightsController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  List<BannerMainHome> list = List.empty();

  EventProvider _eventProvider;
  AuthProvider _authProvider;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _eventProvider = new EventProvider();
    _authProvider = new AuthProvider();
    refresh();
  }

  Future<List<Event>> getEvents() async {
    List<Event> listEvent = await _eventProvider.getEvents();
    listEvent.shuffle();
    return listEvent;
  }
}
