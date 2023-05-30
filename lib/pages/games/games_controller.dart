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
import '../../widgets/button_app.dart';
import 'package:festivia/utils/colors.dart' as utils;
//import 'package:mercado_pago_mobile_checkout/mercado_pago_mobile_checkout.dart';

class GamesController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    refresh();
  }

  void navigate(String navigate) {
    if (navigate.isEmpty) {
      openDialog();
    } else {
      Navigator.pushNamed(context, navigate);
    }
  }

  openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("¡Muy pronto!",
                style: TextStyle(fontSize: 23, fontFamily: "Ubuntu")),
            content: Text(
              "proximamente tendrás mas juegos para previar ;)",
              style: TextStyle(fontSize: 17, fontFamily: "Ubuntu"),
            ),
            actions: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                child: ButtonApp(
                  onPressed: () => {Navigator.pop(context)},
                  text: 'Aceptar',
                  color: utils.Colors.festiviaColor,
                  textColor: Colors.white,
                ),
              ),
            ],
          ));
}
