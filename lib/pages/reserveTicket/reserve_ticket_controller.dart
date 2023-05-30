import 'package:festivia/models/Event.dart';
import 'package:festivia/models/GlobalData.dart';
import 'package:festivia/models/PreSaleTicket.dart';
import 'package:festivia/providers/event_provider.dart';
import 'package:festivia/providers/global_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:festivia/utils/snackbar.dart' as utils;

class ReserveTicketController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  final oCcy = NumberFormat("#,##0.00", "es");

  final EventProvider _eventProvider = EventProvider();
  final GlobalDataProvider _globalDataProvider = GlobalDataProvider();

  GlobalData globalData;

  var arguments;
  Event event;
  String dateParsed = "";
  String idEvent = "";
  double priceGeneral = 0;
  double revenue = 0;
  String infoFree = "";
  String ticketsFree = "";
  String infoGeneral = "";
  String ticketsGeneral = "";
  String dateFree = "";
  String dateGeneral = "";
  bool isFree = false;
  bool isGeneral = false;
  double priceService;
  String priceParced = "";
  String location = "";
  String nameEvent = "";
  String date = "";
  String image = "";
  String availableTicketsFreeText = "Quedan - tickets";
  String availableTicketsGeneralText = "Quedan - tickets";
  String availableTicketsPreSaleText = "Quedan - tickets";
  String typeHost = "";
  String idHost = "";
  List<PreSaleTicket> preSaleTickets = [];

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    globalData = await _globalDataProvider.getDataCommissions();

    arguments = ModalRoute.of(context).settings.arguments as Map;
    priceService = globalData.ticketCommission;
    isFree = arguments["isFree"];
    isGeneral = arguments["isGeneral"];

    dateParsed = arguments["EndFreePass"];
    priceGeneral = arguments["priceGeneral"];
    preSaleTickets = arguments["preSaleTickets"];
    nameEvent = arguments["nameEvent"];
    date = arguments["date"];
    image = arguments["image"];
    idEvent = arguments["idEvent"];
    location = arguments["location"];
    if (isGeneral) {
      revenue = priceGeneral;
      priceGeneral = priceGeneral + (priceGeneral * (priceService / 100));
      priceParced = oCcy.format(priceGeneral);
    }
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

    refresh();
  }

  void generalToOrderPage() {
    if (int.parse(ticketsGeneral) > 0) {
      Navigator.pushNamed(context, 'order', arguments: {
        "type": "general",
        "idEvent": idEvent,
        "priceTicket": priceGeneral,
        "revenue": revenue,
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

  void preSaleToOrderPage(
      int index, double priceTicket, double netPrice, String ticketId) {
    if (preSaleTickets[index].numTickets > 0) {
      Navigator.pushNamed(context, 'order', arguments: {
        "type": "preSale",
        "ticketId": ticketId,
        "idEvent": idEvent,
        "date": date,
        "revenue": netPrice,
        "tittleTicket": preSaleTickets[index].tittle,
        "priceTicket": priceTicket,
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

  String getAvailablesTicketPreSaleText(int index) {
    if (preSaleTickets[index].numTickets <= 0) {
      availableTicketsPreSaleText = "¡AGOTADO!";
    } else {
      availableTicketsPreSaleText = "¡Quedan " +
          preSaleTickets[index].numTickets.toString() +
          " lugares!";
    }
    return availableTicketsPreSaleText;
  }
}
