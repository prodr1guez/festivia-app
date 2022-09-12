import 'package:festivia/pages/liquidateRevenue/liquidate_revenue_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:festivia/utils/colors.dart' as utils;

import '../../widgets/button_app.dart';

class LiquidateRevenuePage extends StatefulWidget {
  @override
  State<LiquidateRevenuePage> createState() => _LiquidateRevenuePageState();
}

class _LiquidateRevenuePageState extends State<LiquidateRevenuePage> {
  LiquidateRevenueController _controller = LiquidateRevenueController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
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
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          "Tus ganancias",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                        Text("\$ " + _controller.revenue.toString(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Costo servicio de Festivia",
                            style: TextStyle(fontSize: 16),
                          )),
                          Text("- \$ " + _controller.totalCommission.toString(),
                              style: TextStyle(fontSize: 20))
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          "TOTAL A LIQUIDAR",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                        Text(" \$ " + _controller.totalRevenue.toString(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          _textFieldName(),
          _textFieldEmail(),
          _textFieldPhone(),
          _textFieldCBU(),
          _buttonRegister()
        ],
      )),
    );
  }

  Widget _textTittle() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20, right: 20, top: 70, bottom: 20),
      child: Text(
        'Ingrese los detalles de la cuenta bancaria',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
      ),
    );
  }

  Widget _textFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _controller.usernameController,
        decoration: InputDecoration(
            hintText: 'Titular de la cuenta',
            labelText: 'Titular de la cuenta',
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
        controller: _controller.cuilController,
        decoration: InputDecoration(
            hintText: '11-111111111-1',
            labelText: 'CUIL (11 DIGITOS)',
            suffixIcon: Icon(
              Icons.person_outline,
            )),
      ),
    );
  }

  Widget _textFieldPhone() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _controller.phoneController,
        decoration: InputDecoration(
            hintText: 'Numero de telefono',
            labelText: 'Numero de telefono',
            suffixIcon: Icon(
              Icons.person_outline,
            )),
      ),
    );
  }

  Widget _textFieldCBU() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _controller.cbuController,
        decoration: InputDecoration(
            hintText: 'CBU (22 Dígitos)',
            labelText: 'CBU (22 Dígitos)',
            suffixIcon: Icon(
              Icons.person_outline,
            )),
      ),
    );
  }

  Widget _buttonRegister() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      child: ButtonApp(
        text: 'Liquidar ganancias',
        color: utils.Colors.festiviaColor,
        textColor: Colors.white,
        onPressed: _controller.register,
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
