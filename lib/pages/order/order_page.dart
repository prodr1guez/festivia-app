import 'package:festivia/pages/order/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:festivia/widgets/button_app.dart';
import 'package:flutter/scheduler.dart';
import 'package:festivia/utils/colors.dart' as utils;
import 'package:url_launcher/url_launcher.dart';

import 'package:festivia/utils/globals.dart' as globals;
import 'package:mercado_pago_mobile_checkout/mercado_pago_mobile_checkout.dart';

import '../../models/Order.dart';
import '../../providers/MP.dart';

class OrderPage extends StatefulWidget {
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  OrderController _controller = new OrderController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Estas interesado?",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          _buttonReserve(),
        ],
      )),
    );
  }

  Widget _buttonReserve() {
    return Container(
      height: 50,
      width: 150,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      child: Container(
        child: ButtonApp(
          onPressed: () => launch(
              "https://www.mercadopago.com.ar/checkout/v1/redirect?pref_id=327976969-8a7dafcd-ce05-47cf-a915-c003ed2075df"),
          text: 'Reservar',
          color: utils.Colors.festiviaColor,
          textColor: Colors.white,
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }

  createOrder() async {
    Order order = new Order(name: "Festivia", price: "10.0");
    startMp();
  }

  void startMp() {
    print("--");

    armarPreferencia().then((result) async {
      if (result != null) {
        var preferenceId = result['response']['init_point'];
        print(preferenceId);

        //var response = await MercadoPagoMobileCheckout.startCheckout(
        //  globals.mpPublicKey, preferenceId);

        //print(response);
      }
    });
  }

  Future<Map<String, dynamic>> armarPreferencia() async {
    var mp = MP(globals.mpClientID, globals.mpClientSecret);
    var preference = {
      "items": [
        {
          "id": "1234",
          "title": "Test Modified",
          "quantity": 1,
          "currency_id": "ARS",
          "unit_price": 10.0,
          "description": "ticket"
        }
      ],
      "payer": {
        "name": "valentina aliaga",
        "email": "valea200215@gmail.com",
        "address": {"street_name": "rio diamante 426"}
      },
      "payment_methods": {
        "excluded_payment_types": [
          {"id": "credit_card"}
        ]
      }
    };

    var result = await mp.createPreference(preference);

    //print(result);
    return result;
  }
}
