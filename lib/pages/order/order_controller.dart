import 'package:festivia/models/BannerMainHome.dart';
import 'package:festivia/models/HostEvent.dart';
import 'package:festivia/models/Ticket.dart';
import 'package:festivia/providers/auth_provider.dart';
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
  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  MyEventsProvider _myEventsProvider;
  AuthProvider _authProvider;
  TicketProvider _ticketProvider;
  var arguments;
  String idEvent;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    arguments = ModalRoute.of(context).settings.arguments as Map;
    idEvent = arguments["idEvent"];
    print(idEvent);
    _myEventsProvider = new MyEventsProvider();
    _authProvider = new AuthProvider();
    _ticketProvider = new TicketProvider();
    refresh();
  }

  Future<List<HostEvent>> getMyEvents() async {
    return await _myEventsProvider.getMyEvents(_authProvider.getUser().uid);
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
    Navigator.pushNamed(context, 'ticket_page', arguments: {"idTicket": id});

    //_ticketProvider.create(ticket, idEvent);
  }
}
