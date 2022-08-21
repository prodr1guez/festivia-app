import 'package:festivia/models/Event.dart';
import 'package:festivia/providers/event_provider.dart';
import 'package:flutter/material.dart';

import '../../utils/DateParsed.dart';

class DetailEventController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  EventProvider _eventProvider = new EventProvider();

  String idEvent;
  Event event;
  String dateStartParsed = "";
  String dateEndParsed = "";
  String location;

  Future init(BuildContext context, Function refresh, String idEvent) async {
    this.context = context;
    this.refresh = refresh;
    getEventInfo(idEvent);
  }

  void getEventInfo(String id) async {
    event = await _eventProvider.getById(id);

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
      "maxTicketsFree": event.maxTicketsFreePass,
      "maxTicketsGeneral": event.maxTicketsPaidOffEvent,
      "descriptionTicketGeneral": event.descriptionTicketGeneral,
      "location": event.location,
      "typeHost": event.typeHost,
      "idHost": event.idHost
    });
  }
}
