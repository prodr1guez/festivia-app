import 'package:festivia/pages/order/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:festivia/widgets/button_app.dart';
import 'package:flutter/scheduler.dart';
import 'package:festivia/utils/colors.dart' as utils;

import 'package:festivia/utils/globals.dart' as globals;
import 'package:mercado_pago_mobile_checkout/mercado_pago_mobile_checkout.dart';
import 'package:festivia/utils/snackbar.dart' as utils;

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
                image: NetworkImage(_controller.image.isNotEmpty
                    ? _controller.image
                    : "https://miro.medium.com/max/1372/1*-hfgomjwoby91XbKRwYZvw.png"),
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
          onPressed: () => {openDialog()},
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
        _controller.nameEvent,
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
        _controller.date,
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
        controller: _controller.lastNameController,
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
    if (_controller.nameController.text.isEmpty ||
        _controller.lastNameController.text.isEmpty) {
      utils.Snackbar.showSnackbar(
          context, _controller.key, 'Complete todo los datos');
    } else {
      _controller.showDialog();
      startMp();
    }
  }

  openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Aviso",
                style: TextStyle(fontSize: 23, fontFamily: "Ubuntu")),
            content: Text(
              "Cualquier cambio que se realice a un evento tras la compra de una entrada, como un cambio de fecha, de hora, de lugar, de programa, de artista o cancelación del evento, será responsabilidad del organizador de dicho evento y no de Festivia",
              style: TextStyle(fontSize: 17, fontFamily: "Ubuntu"),
            ),
            actions: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                child: ButtonApp(
                  onPressed: () => {createOrder()},
                  text: 'Continuar',
                  color: utils.Colors.festiviaColor,
                  textColor: Colors.white,
                ),
              ),
            ],
          ));

  void startMp() {
    armarPreferencia().then((result) async {
      if (result != null) {
        var linkMP = result['response']['init_point'];
        var preferenceId = result['response']['id'];

        var response = await MercadoPagoMobileCheckout.startCheckout(
            globals.mpPublicKey, preferenceId);

        if (response.result == "done" && response.status == "approved") {
          _controller.hideDialog();
          Navigator.pop(context);
          _controller.addTicket(_controller.revenue);
        } else {
          _controller.hideDialog();
          Navigator.pop(context);
          utils.Snackbar.showSnackbar(
              context, _controller.key, 'NO SE PUDO REALIZAR EL PAGO');
        }
      }
    });
  }

  Future<Map<String, dynamic>> armarPreferencia() async {
    var mp = MP(globals.mpClientID, globals.mpClientSecret);
    var priceTicket;
    if (_controller.type == "preSale") {
      priceTicket = _controller.priceTicket;
    } else {
      _controller.tittleTicket = "Entrada General";
      priceTicket = _controller.priceTicket;
    }
    var preference = {
      "items": [
        {
          "id": "1234",
          "title": _controller.nameEvent + ", " + _controller.tittleTicket,
          "quantity": 1,
          "currency_id": "ARS",
          "unit_price": priceTicket,
          "description": _controller.nameEvent
        }
      ],
      "payer": {
        "name": _controller.nameController.text,
        "email": _controller.emailController.text,
      },
      "payment_methods": {
        "excluded_payment_types": [
          {"id": "credit_card"},
          {"id": "ticket"},
          {"id": "atm"},
        ]
      }
    };

    var result = await mp.createPreference(preference);

    return result;
  }
}
