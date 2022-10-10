import 'package:festivia/providers/club_provider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/Club.dart';
import '../../models/HostEvent.dart';

class ContactClubController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  String email = "";
  String phone = "";
  String location = "";

  var arguments;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    arguments = ModalRoute.of(context).settings.arguments as Map;

    email = arguments["email"];
    phone = arguments["phone"];
    location = arguments["location"];

    refresh();
  }
}
