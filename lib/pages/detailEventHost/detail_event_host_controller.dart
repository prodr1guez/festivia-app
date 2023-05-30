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
  bool showStats = false;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    idEvent = ModalRoute.of(context).settings.arguments as String;
    await getEventInfo();
    showStats = !event.isInformative;
  }

  void getEventInfo() async {
    event = await _eventProvider.getById(idEvent);
    refresh();
  }

  navigateToEditEvent(BuildContext context) {
    Navigator.pushNamed(context, 'edit_event', arguments: event);
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

    Navigator.pushNamed(context, 'event_stats', arguments: idEvent);
  }
}
