import 'package:festivia/models/Event.dart';
import 'package:festivia/providers/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:festivia/utils/snackbar.dart' as utils;

class ReserveTicketController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  final oCcy = new NumberFormat("#,##0.00", "es");

  EventProvider _eventProvider = new EventProvider();

  var arguments;
  Event event;
  String dateParsed = "";
  String idEvent = "";
  double priceGeneral = 0;
  String infoFree = "";
  String ticketsFree = "";
  String infoGeneral = "";
  String ticketsGeneral = "";
  String dateFree = "";
  String dateGeneral = "";
  bool isFree = false;
  bool isGeneral = false;
  double priceService = 0.15;
  String priceParced = "";
  String location = "";
  String nameEvent = "";
  String date = "";
  String image = "";
  String availableTicketsFreeText = "Quedan - tickets";
  String availableTicketsGeneralText = "Quedan - tickets";
  String typeHost = "";
  String idHost = "";

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    arguments = ModalRoute.of(context).settings.arguments as Map;

    isFree = arguments["isFree"];
    dateParsed = arguments["EndFreePass"];
    isGeneral = arguments["isGeneral"];
    priceGeneral = arguments["priceGeneral"];
    nameEvent = arguments["nameEvent"];
    date = arguments["date"];
    image = arguments["image"];
    idEvent = arguments["idEvent"];
    location = arguments["location"];
    priceGeneral = priceGeneral + (priceGeneral * priceService);
    priceParced = oCcy.format(priceGeneral);
    infoFree = arguments["descriptionTicketFree"];
    infoGeneral = arguments["descriptionTicketGeneral"];
    ticketsFree = arguments["maxTicketsFree"].toString();
    ticketsGeneral = arguments["maxTicketsGeneral"].toString();
    typeHost = arguments["typeHost"];
    idHost = arguments["idHost"];

    if (int.parse(ticketsFree) <= 0) {
      availableTicketsFreeText = "¡AGOTADO!";
    } else {
      availableTicketsFreeText = "¡Quedan " + ticketsFree + " lugares!";
    }

    if (int.parse(ticketsGeneral) <= 0) {
      availableTicketsGeneralText = "¡AGOTADO!";
    } else {
      availableTicketsGeneralText = "¡Quedan " + ticketsGeneral + " lugares!";
    }

    refresh();
  }

  void getEventInfo() async {
    event = await _eventProvider.getById("idEvent");
    print(event.image);
    refresh();
  }

  void generalToOrderPage() {
    if (int.parse(ticketsGeneral) > 0) {
      Navigator.pushNamed(context, 'order', arguments: {
        "type": "general",
        "idEvent": idEvent,
        "priceGeneral": priceGeneral,
        "date": date,
        "location": location,
        "nameEvent": nameEvent,
        "image": image,
        "typeHost": typeHost,
        "idHost": idHost
      });
    } else {
      utils.Snackbar.showSnackbar(context, key, 'Entradas agotadas');
    }
  }

  void freeToOrderPage() {
    print("---" + idEvent);
    if (int.parse(ticketsFree) > 0) {
      Navigator.pushNamed(context, 'order', arguments: {
        "type": "free",
        "idEvent": idEvent,
        "date": date,
        "location": location,
        "nameEvent": nameEvent,
        "image": image,
        "typeHost": typeHost,
        "idHost": idHost
      });
    } else {
      utils.Snackbar.showSnackbar(context, key, 'Entradas agotadas');
    }
  }

  void vipToOrderPage() {
    Navigator.pushNamed(context, 'order',
        arguments: {"type": "vip", "idEvent": idEvent});
  }
}
