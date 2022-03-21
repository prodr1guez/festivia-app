import 'package:festivia/models/Event.dart';
import 'package:festivia/providers/event_provider.dart';
import 'package:flutter/material.dart';

class DetailEventController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  EventProvider _eventProvider = new EventProvider();

  String idEvent;
  Event event;
  String dateParsed;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    idEvent = ModalRoute.of(context).settings.arguments as String;
    print(idEvent + "-------");

    getEventInfo();
  }

  void getEventInfo() async {
    event = await _eventProvider.getById(idEvent);
    print(event.image);
    refresh();
  }

  void goToReserve() {
    bool isFree = false;
    bool isPaidOff = false;
    if (event?.isFree != null && event.isFree) {
      isFree = true;
    }

    if (event?.isPaidOff != null && event.isPaidOff) {
      isPaidOff = true;
    }

    Navigator.pushNamed(context, 'reserve_tickets', arguments: {
      "isFree": isFree,
      "isPaidOff": isPaidOff,
      "EndFreePass": event.dateEndFreePassParsed
    });
  }
}
