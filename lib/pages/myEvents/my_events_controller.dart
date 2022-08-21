import 'package:festivia/models/BannerMainHome.dart';
import 'package:festivia/models/HostEvent.dart';
import 'package:festivia/models/User.dart';
import 'package:festivia/providers/auth_provider.dart';
import 'package:festivia/providers/club_provider.dart';
import 'package:festivia/providers/my_events_provider.dart';
import 'package:festivia/providers/user_provider.dart';
import 'package:flutter/material.dart';

class MyEventController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  List<BannerMainHome> list = List.empty();

  MyEventsProvider _myEventsProvider;
  AuthProvider _authProvider;
  UserProvider _userProvider;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _myEventsProvider = new MyEventsProvider();
    _userProvider = new UserProvider();
    _authProvider = new AuthProvider();
    refresh();
  }

  Future<List<HostEvent>> getMyEvents() async {
    User user = await _userProvider.getById(_authProvider.getUser().uid);

    if (user.type.contains("club")) {
      ClubProvider clubProvider = new ClubProvider();
      return await clubProvider.EventsClub(_authProvider.getUser().uid);
    } else {
      return await _myEventsProvider.getMyEvents(_authProvider.getUser().uid);
    }
  }
}
