import 'package:festivia/models/Event.dart';
import 'package:festivia/providers/event_provider.dart';
import 'package:flutter/material.dart';

class EventStatsController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  EventProvider _eventProvider = new EventProvider();

  String idEvent;
  Event event = Event(
      assistants: 0,
      generalTicketsSold: 0,
      freeTicketsSold: 0,
      vipTicketsSold: 0,
      revenue: 0.0);
  String dateParsed;
  String location;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    idEvent = ModalRoute.of(context).settings.arguments as String;

    getEventInfo();
  }

  void getEventInfo() async {
    print(idEvent);
    event = await _eventProvider.getById(idEvent);
    refresh();
  }
}
