import 'package:festivia/models/Ticket.dart';
import 'package:festivia/pages/order/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:festivia/widgets/button_app.dart';
import 'package:flutter/scheduler.dart';
import 'package:festivia/utils/colors.dart' as utils;
import 'package:parallax_image/parallax_image.dart';
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
      key: _controller.key,
      body: SingleChildScrollView(
          child: Column(
        children: [
          _textTittle(),
          _textSubTittle(),
          Container(
            margin: EdgeInsets.only(top: 5),
            height: 150,
            width: 350,
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image(
                image: NetworkImage(
                    "https://static6.ticketek.com.ar/cms_static/sites/default/files/images/show-header/pack-portada-960x400.png"),
                fit: BoxFit.cover,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin: EdgeInsets.all(10),
            ),
          ),
          _textRegister(),
          _textFieldName(),
          _textFieldLastName(),
          _textFieldEmail(),
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Todo listo?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _controller.type == "free" ? _buttonReserve() : _buttonReserve2()
            ],
          ))
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
          onPressed: () => _controller.addTicketFree(),
          text: 'Reservar',
          color: utils.Colors.festiviaColor,
          textColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buttonReserve2() {
    return Container(
      height: 50,
      width: 150,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      child: Container(
        child: ButtonApp(
          onPressed: () => {createOrder()},
          text: 'ir al Checkout',
          color: utils.Colors.festiviaColor,
          textColor: Colors.white,
        ),
      ),
    );
  }

  Widget _textRegister() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20, top: 20),
      child: Text(
        'Datos del comprador',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  Widget _textTittle() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20, top: 70),
      child: Text(
        'Festivia party 2.0',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
      ),
    );
  }

  Widget _textSubTittle() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20, top: 5),
      child: Text(
        'Sabado 2 de julio de 2022 | 17:00 - 01:30',
        style: TextStyle(color: Colors.black, fontSize: 14),
      ),
    );
  }

  Widget _textFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _controller.nameController,
        decoration: InputDecoration(
            labelText: 'Nombre',
            suffixIcon: Icon(
              Icons.person_outline,
            )),
      ),
    );
  }

  Widget _textFieldLastName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _controller.nameController,
        decoration: InputDecoration(
            labelText: 'Apellido',
            suffixIcon: Icon(
              Icons.person_outline,
            )),
      ),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _controller.emailController,
        decoration: InputDecoration(
            hintText: 'Pepito Perez',
            labelText: 'Email',
            suffixIcon: Icon(
              Icons.person_outline,
            )),
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
        var linkMP = result['response']['init_point'];
        var preferenceId = result['response']['id'];

        var response = await MercadoPagoMobileCheckout.startCheckout(
            globals.mpPublicKey, preferenceId);

        print(response);
        print(response.result);

        if (response.result == "done") {
          print("PAGO REALIZADO");
          _controller.addTicket();
        } else {
          print("NO SE PUDO REALIZAR EL PAGO");
        }
      }
    });
  }

  Future<Map<String, dynamic>> armarPreferencia() async {
    var mp = MP(globals.mpClientID, globals.mpClientSecret);

    print(_controller.priceGeneral);
    print(_controller.description);
    print(_controller.nameController.text);
    print(_controller.emailController.text);
    var preference = {
      "items": [
        {
          "id": "1234",
          "title": "Test Modified",
          "quantity": 1,
          "currency_id": "ARS",
          "unit_price": _controller.priceGeneral,
          "description": _controller.description
        }
      ],
      "payer": {
        "name": _controller.nameController.text,
        "email": _controller.emailController.text,
      },
      "payment_methods": {
        "excluded_payment_types": [
          {"id": "credit_card"}
        ]
      }
    };

    var result = await mp.createPreference(preference);

    print("okey" + result.toString());
    return result;
  }
}
