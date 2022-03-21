import 'package:festivia/models/Event.dart';
import 'package:festivia/providers/event_provider.dart';
import 'package:flutter/material.dart';

class ReserveTicketController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  EventProvider _eventProvider = new EventProvider();

  var arguments;
  Event event;
  String dateParsed = "";

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    arguments = ModalRoute.of(context).settings.arguments as Map;
    print(arguments["isFree"]);
    print(arguments["isPaidOff"]);
    dateParsed = arguments["EndFreePass"];
    refresh();
  }

  void getEventInfo() async {
    event = await _eventProvider.getById("idEvent");
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
    });
  }

  goToOrderPage() {
    Navigator.pushNamed(context, 'order');
  }
}
