import 'package:festivia/pages/register/register_controller.dart';
import 'package:festivia/widgets/button_app.dart';
import 'package:flutter/material.dart';
import 'package:festivia/utils/colors.dart' as utils;
import 'package:flutter/scheduler.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterController _controller = RegisterController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      _controller.init(context);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _controller.key,
      body: SingleChildScrollView(
          child: Column(
        children: [
          _textRegister(),
          _textFieldName(),
          _textFieldEmail(),
          _textFieldPassword(),
          _buttonRegister()
        ],
      )),
    );
  }

  Widget _textRegister() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
      child: Text(
        'Registrar',
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
            hintText: 'Nombre',
            labelText: 'Nombre',
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
            hintText: 'Email',
            labelText: 'Email',
            suffixIcon: Icon(
              Icons.person_outline,
            )),
      ),
    );
  }

  Widget _textFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: TextField(
        controller: _controller.passwordController,
        obscureText: true,
        decoration: InputDecoration(
            labelText: 'Contraseña',
            suffixIcon: Icon(
              Icons.lock_open_outlined,
            )),
      ),
    );
  }

  Widget _buttonRegister() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      child: ButtonApp(
        text: 'Registrar',
        color: utils.Colors.festiviaColor,
        textColor: Colors.white,
        onPressed: _controller.register,
      ),
    );
  }
}
