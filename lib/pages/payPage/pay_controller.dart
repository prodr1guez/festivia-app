import 'package:festivia/models/BannerMainHome.dart';
import 'package:festivia/models/HostEvent.dart';
import 'package:festivia/providers/auth_provider.dart';
import 'package:festivia/providers/my_events_provider.dart';
import 'package:flutter/material.dart';
//import 'package:mercado_pago_mobile_checkout/mercado_pago_mobile_checkout.dart';

class PayController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  List<BannerMainHome> list = List.empty();

  MyEventsProvider _myEventsProvider;
  AuthProvider _authProvider;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _myEventsProvider = new MyEventsProvider();
    _authProvider = new AuthProvider();
    refresh();
  }

  Future<List<HostEvent>> getMyEvents() async {
    return await _myEventsProvider.getMyEvents(_authProvider.getUser().uid);
  }

  createOrder() async {
    // var result = MercadoPagoMobileCheckout.startCheckout(
    //     "TEST-eac10d75-59c1-48ed-af5e-a4744dafc954",
    //     "327976969-f7642b8c-b895-4bd6-9aee-adea2d577883");
  }
}
