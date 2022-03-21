import 'package:festivia/models/BannerMainHome.dart';
import 'package:festivia/models/SuggestClub.dart';
import 'package:festivia/models/SuggestParty.dart';
import 'package:festivia/providers/auth_provider.dart';
import 'package:festivia/providers/banners_providers.dart';
import 'package:festivia/widgets/mini_card_home.dart';
import 'package:flutter/material.dart';

import '../../models/HostEvent.dart';
import '../../providers/my_events_provider.dart';

class HomeController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  List<BannerMainHome> list = List.empty();
  MyEventsProvider _myEventsProvider = MyEventsProvider();
  AuthProvider _authProvider = AuthProvider();
  BannersProvider _bannersProvider;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _bannersProvider = new BannersProvider();
    refresh();
  }

  Future<List<BannerMainHome>> getBannerMain() async {
    return await _bannersProvider.getBannersData();
  }

  Future<List<SuggestParty>> getSuggestsParty() async {
    return await _bannersProvider.getSuggestPartiesData();
  }

  Future<List<SuggestClub>> getSuggestsClubs() async {
    return await _bannersProvider.getSuggestClubsData();
  }
}
