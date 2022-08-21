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
      _controller.init(context);
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
          _textFieldName(),
          _textFieldEmail(),
          _textFieldPhone(),
          _textFieldCBU(),
          _textFieldConfirmCBU(),
          _buttonRegister()
        ],
      )),
    );
  }

  Widget _textTittle() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20, right: 20, top: 70, bottom: 50),
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
        controller: _controller.emailController,
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
        controller: _controller.emailController,
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
        controller: _controller.emailController,
        decoration: InputDecoration(
            hintText: 'CBU (22 Dígitos)',
            labelText: 'CBU (22 Dígitos)',
            suffixIcon: Icon(
              Icons.person_outline,
            )),
      ),
    );
  }

  Widget _textFieldConfirmCBU() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _controller.emailController,
        decoration: InputDecoration(
            hintText: 'Confirme CBU',
            labelText: 'Confirme CBU',
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
}
