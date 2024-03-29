import 'package:festivia/pages/login/login_controller.dart';
import 'package:festivia/widgets/button_app.dart';
import 'package:flutter/material.dart';
import 'package:festivia/utils/colors.dart' as utils;
import 'package:flutter/scheduler.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController _con = new LoginController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.key,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _textLogin(),
            _textFieldUsername(),
            _textFieldPassword(),
            _buttonLogin(),
            _buttonForgotPass()
          ],
        ),
      ),
    );
  }

  Widget _textLogin() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
      child: Text(
        'Iniciar sesión',
        style: TextStyle(
            fontFamily: "Ubuntu",
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25),
      ),
    );
  }

  Widget _textFieldUsername() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _con.emailController,
        decoration: InputDecoration(
            hintText: 'Email',
            labelText: 'Email',
            suffixIcon: Icon(
              Icons.person_outline,
              color: utils.Colors.festiviaColor,
            )),
      ),
    );
  }

  Widget _textFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: TextField(
        controller: _con.passwordController,
        obscureText: true,
        decoration: InputDecoration(
            labelText: 'Contraseña',
            suffixIcon: Icon(
              Icons.lock_open_outlined,
              color: utils.Colors.festiviaColor,
            )),
      ),
    );
  }

  Widget _buttonLogin() {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 20),
      child: ButtonApp(
        onPressed: _con.login,
        text: 'Iniciar sesión',
        color: utils.Colors.festiviaColor,
        textColor: Colors.white,
      ),
    );
  }

  Widget _buttonForgotPass() {
    return InkWell(
      onTap: () => _con.navigateToForgotPass(context),
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Text(
            "¿Olvidaste tu contraseña?",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "Ubuntu"),
          )),
    );
  }

  void refresh() {
    setState(() {});
  }
}
