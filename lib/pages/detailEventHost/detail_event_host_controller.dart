import 'package:festivia/models/Event.dart';
import 'package:festivia/providers/event_provider.dart';
import 'package:flutter/material.dart';

class DetailEventHostController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  EventProvider _eventProvider = new EventProvider();

  String idEvent;
  Event event;
  String dateParsed;
  String location;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    idEvent = ModalRoute.of(context).settings.arguments as String;
    print(idEvent + "-------");

    getEventInfo();
  }

  void getEventInfo() async {
    event = await _eventProvider.getById(idEvent);

    refresh();
  }

  void goToReserve() {
    bool isFree = false;
    bool isPaidOff = false;
    double priceGeneral;
    if (event?.isFree != null && event.isFree) {
      isFree = true;
    }

    if (event?.isPaidOff != null && event.isPaidOff) {
      isPaidOff = true;
      priceGeneral = double.parse(event.price);
    }

    Navigator.pushNamed(context, 'reserve_tickets', arguments: {
      "isFree": isFree,
      "isGeneral": isPaidOff,
      "priceGeneral": priceGeneral,
      "info": event.description,
      "EndFreePass": event.dateEndFreePassParsed,
      "idEvent": idEvent,
      "nameEvent": event.tittle,
      "date": event.dateStartParsed,
      "image": event.image,
      "descriptionTicketFree": event.descriptionTicketFree,
      "descriptionTicketGeneral": event.descriptionTicketGeneral,
      "location": event.location
    });
  }

  void goToEventStats() {
    bool isFree = false;
    bool isPaidOff = false;
    double priceGeneral;
    if (event?.isFree != null && event.isFree) {
      isFree = true;
    }

    if (event?.isPaidOff != null && event.isPaidOff) {
      isPaidOff = true;
      priceGeneral = double.parse(event.price);
    }

    Navigator.pushNamed(context, 'event_stats');
  }
}
