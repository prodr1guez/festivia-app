import 'package:festivia/models/BannerMainHome.dart';
import 'package:festivia/models/Ticket.dart';
import 'package:festivia/providers/auth_provider.dart';
import 'package:festivia/providers/client_provider.dart';
import 'package:festivia/providers/my_events_provider.dart';
import 'package:festivia/providers/ticket_provider.dart';

import 'package:flutter/material.dart';
import 'package:min_id/min_id.dart';
//import 'package:mercado_pago_mobile_checkout/mercado_pago_mobile_checkout.dart';

class OrderController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  List<BannerMainHome> list = List.empty();
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();

  MyEventsProvider _myEventsProvider;
  AuthProvider _authProvider;
  TicketProvider _ticketProvider;
  ClientProvider _clientProvider;
  var arguments;
  String idEvent;

  String type = "";
  double priceGeneral;

  String email = "";
  String name = "";
  String lastname = "";
  String description = "Entrada general";
  String date = "";
  String nameEvent = "";
  String image = "";

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    arguments = ModalRoute.of(context).settings.arguments as Map;

    print(arguments);
    idEvent = arguments["idEvent"];
    priceGeneral = arguments["priceGeneral"];
    type = arguments["type"];
    date = arguments["date"];
    nameEvent = arguments["nameEvent"];
    image = arguments["image"];

    _myEventsProvider = new MyEventsProvider();
    _authProvider = new AuthProvider();
    _ticketProvider = new TicketProvider();
    _clientProvider = new ClientProvider();

    nameController.text = name;
    emailController.text = _authProvider.getUser().email;

    refresh();
  }

  createOrder() async {
    // var result = await MercadoPagoMobileCheckout.startCheckout(
    //     "TEST-eac10d75-59c1-48ed-af5e-a4744dafc954",
    //     "327976969-f7642b8c-b895-4bd6-9aee-adea2d577883");
  }

  void addTicket() {
    String id = MinId.getId('3{w}3{d}').toUpperCase();
    Ticket ticket = Ticket(ticketId: id);
    print("ORDERPAGE:  " + id);
    //Navigator.pushNamed(context, 'ticket_page', arguments: {"idTicket": id});

    //_ticketProvider.create(ticket, idEvent);
  }

  void addTicketFree() {
    String id = MinId.getId('3{w}3{d}').toUpperCase();
    Ticket ticket = Ticket(
        ticketId: id,
        payId: _authProvider.getUser().uid,
        name: nameController.text,
        nameEvent: nameEvent,
        type: type,
        date: date,
        image: image);
    print("ORDERPAGE:  " + ticket.toString());
    //Navigator.pushNamed(context, 'ticket_page', arguments: {"idTicket": id});

    _ticketProvider.create(ticket, idEvent);
  }
}
