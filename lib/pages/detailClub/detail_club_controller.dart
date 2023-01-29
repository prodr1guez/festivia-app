import 'package:festivia/providers/club_provider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/Club.dart';
import '../../models/HostEvent.dart';

class DetailClubController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  final ClubProvider _clubProvider = ClubProvider();

  String idClub;
  Club club;
  String dateParsed;
  String location;
  List<HostEvent> listEvent;
  bool nextevents = false;
  double lat;
  double long;

  Future init(BuildContext context, Function refresh, String id) async {
    this.context = context;
    this.refresh = refresh;
    idClub = id;
    getClubInfo();
  }

  Future<List<HostEvent>> getMyEvents() async {
    return await _clubProvider.EventsClub(idClub);
  }

  Future<List<HostEvent>> getEventsClub() async {
    if (listEvent == null) {
      var events = await _clubProvider.EventsForClub(idClub);
      if (events.isNotEmpty) {
        nextevents = true;
        refresh();
      }
      return events;
    }

    return listEvent;
  }

  void getClubInfo() async {
    club = await _clubProvider.getById(idClub);
    lat = club.lat;
    long = club.long;
    refresh();
  }

  navigateToContactClub(BuildContext context) {
    Navigator.pushNamed(context, 'contact_club_page', arguments: {
      "email": club.email,
      "phone": club.phone,
      "location": club.location
    });
  }

  navigateToMapPage(BuildContext context) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not open the map.';
    }
  }
}
