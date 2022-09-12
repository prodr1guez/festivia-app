import 'package:festivia/pages/forgotPassword/forgot_pass_controller.dart';
import 'package:festivia/responses/forgot_pass_response.dart';
import 'package:festivia/widgets/button_app.dart';
import 'package:flutter/material.dart';
import 'package:festivia/utils/colors.dart' as utils;
import 'package:flutter/scheduler.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:festivia/utils/snackbar.dart' as utils;

final ForgotPassProvider = SimpleProvider((_) => ForgotPassController());

class ForgotPassPage extends StatefulWidget {
  @override
  _ForgotPassPageState createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  ForgotPassController _con = new ForgotPassController();

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
    return ProviderListener<ForgotPassController>(
        provider: ForgotPassProvider,
        builder: (_, controller) => Scaffold(
            key: _con.key,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  _textLogin(),
                  _textFieldUsername(controller),
                  _buttonLogin(),
                ],
              ),
            )));
  }

  Widget _textLogin() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
      child: Text(
        'Recuperar contraseña',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
      ),
    );
  }

  Widget _textFieldUsername(ForgotPassController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        onChanged: controller.onEmailChanged,
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

  Widget _buttonLogin() {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 20),
      child: ButtonApp(
        onPressed: () => {_submit(context)},
        text: 'Enviar codigo',
        color: utils.Colors.festiviaColor,
        textColor: Colors.white,
      ),
    );
  }

  void refresh() {
    setState(() {});
  }

  void _submit(BuildContext context) async {
    _con.progressDialog.show();
    final controller = ForgotPassProvider.read;

    if (controller.email.isNotEmpty) {
      final response = await controller.submit();

      if (response == ForgotPassResponse.ok) {
        _con.progressDialog.hide();
        print("Codigo enviado");
      } else {
        _con.progressDialog.hide();
        String errorMesage = "";
        switch (response) {
          case ForgotPassResponse.networkRequestFailed:
            errorMesage = "Error de conexión";
            break;
          case ForgotPassResponse.userDisabled:
            errorMesage = "Usuario desactivado";
            break;
          case ForgotPassResponse.wrongPassword:
            errorMesage = "Contraseña invalida";
            break;
          case ForgotPassResponse.toManyRequest:
            errorMesage = "Demasiadas peticiones";
            break;
          case ForgotPassResponse.unknown:
            errorMesage = "Error Desconocido";
            break;

          default:
            errorMesage = "Error Desconocido";
        }

        print(errorMesage);
        utils.Snackbar.showSnackbar(
            context, _con.key, 'El usuario no es valido');
      }
    }
  }
}
