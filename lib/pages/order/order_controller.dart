import 'package:festivia/models/BannerMainHome.dart';
import 'package:festivia/models/Ticket.dart';
import 'package:festivia/providers/auth_provider.dart';
import 'package:festivia/providers/client_provider.dart';
import 'package:festivia/providers/my_events_provider.dart';
import 'package:festivia/providers/ticket_provider.dart';

import 'package:flutter/material.dart';
import 'package:min_id/min_id.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:festivia/utils/snackbar.dart' as utils;

import '../../models/PreSaleTicket.dart';
import '../../utils/my_progress_dialog.dart';
//import 'package:mercado_pago_mobile_checkout/mercado_pago_mobile_checkout.dart';

class OrderController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  List<BannerMainHome> list = List.empty();
  TextEditingController nameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  ProgressDialog _progressDialog;

  MyEventsProvider _myEventsProvider;
  AuthProvider _authProvider;
  TicketProvider _ticketProvider;
  ClientProvider _clientProvider;
  var arguments;
  String idEvent;

  String type = "";
  double priceGeneral;
  double revenue;

  String email = "";
  String name = "";
  String lastname = "";
  String description = "Entrada general";
  String date = "";
  String nameEvent = "";
  String image = "";
  String typeHost = "";
  String idHost = "";
  String location = "";
  String tittleTicket = "";
  double priceTicket;
  String ticketId = "";

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    arguments = ModalRoute.of(context).settings.arguments as Map;
    _progressDialog =
        MyProgressDialog.createProgressDialog(context, 'Espere un momento...');

    idEvent = arguments["idEvent"];
    priceTicket = arguments["priceTicket"];
    revenue = arguments["revenue"];
    type = arguments["type"];
    date = arguments["date"];
    nameEvent = arguments["nameEvent"];
    tittleTicket = arguments["tittleTicket"];
    image = arguments["image"];
    typeHost = arguments["typeHost"];
    idHost = arguments["idHost"];
    location = arguments["location"];
    ticketId = arguments["ticketId"];

    _myEventsProvider = new MyEventsProvider();
    _authProvider = new AuthProvider();
    _ticketProvider = new TicketProvider();
    _clientProvider = new ClientProvider();

    nameController.text = name;
    lastNameController.text = lastname;
    emailController.text = _authProvider.getUser().email;

    refresh();
  }

  createOrder() async {
    // var result = await MercadoPagoMobileCheckout.startCheckout(
    //     "TEST-eac10d75-59c1-48ed-af5e-a4744dafc954",
    //     "327976969-f7642b8c-b895-4bd6-9aee-adea2d577883");
  }

  void showDialog() {
    _progressDialog.show();
  }

  void hideDialog() {
    _progressDialog.hide();
  }

  Future<void> addTicket(double revenue) async {
    _progressDialog.show();
    String id = MinId.getId('3{w}3{d}').toUpperCase();

    Ticket ticket = Ticket(
        ticketId: id,
        payId: _authProvider.getUser().uid,
        name: nameController.text,
        nameEvent: nameEvent,
        location: location,
        type: type,
        date: date,
        image: image,
        checkedIn: false);

    await _ticketProvider.create(
        ticket, idEvent, revenue, typeHost, idHost, ticketId);

    _progressDialog.hide();

    Navigator.pushNamedAndRemoveUntil(context, 'navigation', (route) => false,
        arguments: {"index": 3});
  }

  Future<void> addTicketFree() async {
    if (nameController.text.isEmpty || lastNameController.text.isEmpty) {
      utils.Snackbar.showSnackbar(context, key, 'Complete todo los datos');
    } else {
      _progressDialog.show();
      String id = MinId.getId('3{w}3{d}').toUpperCase();
      Ticket ticket = Ticket(
          ticketId: id,
          payId: _authProvider.getUser().uid,
          name: nameController.text,
          nameEvent: nameEvent,
          location: location,
          type: type,
          date: date,
          image: image,
          checkedIn: false);

      await _ticketProvider.create(
          ticket, idEvent, 0, typeHost, idHost, ticketId);

      _progressDialog.hide();

      utils.Snackbar.showSnackbar(
          context, key, 'El usuario se registro correctamente');

      Navigator.pushNamedAndRemoveUntil(context, 'navigation', (route) => false,
          arguments: {"index": 3});
    }
  }
}
