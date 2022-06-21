import 'package:festivia/pages/profile/profile_controller.dart';
import 'package:festivia/widgets/button_app.dart';
import 'package:flutter/material.dart';
import 'package:festivia/utils/colors.dart' as utils;
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileController _con = new ProfileController();

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
      bottomSheet: _buttonRegister(),
      key: _con.key,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                _bannerApp(),
                _rowButtons(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        "Tus datos",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                ),
                RowEmail(),
                RowPhone(),
                RowCity(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: EdgeInsets.only(left: 20, top: 15),
                      child: Text(
                        "Datos de facturación",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                ),
                RowCbu(),
                RowAlias(),
                RowTitular(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container RowEmail() {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 5),
      child: Row(
        children: [
          Text(
            "Email: ",
            style: TextStyle(fontSize: 16),
          ),
          Text(
            "pablo_rodr1guez@hotmail.com ",
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }

  Container RowPhone() {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 5),
      child: Row(
        children: [
          Text(
            "Teléfono: ",
            style: TextStyle(fontSize: 16),
          ),
          Text(
            "2612541365",
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }

  Container RowCity() {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 5),
      child: Row(
        children: [
          Text(
            "Ciudad: ",
            style: TextStyle(fontSize: 16),
          ),
          Text(
            "Mendoza",
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }

  Container RowCbu() {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 5),
      child: Row(
        children: [
          Text(
            "CBU: ",
            style: TextStyle(fontSize: 16),
          ),
          Text(
            "000012131241131212",
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }

  Container RowAlias() {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 5),
      child: Row(
        children: [
          Text(
            "Alias: ",
            style: TextStyle(fontSize: 16),
          ),
          Text(
            "prodriguez.bru.5668",
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }

  Container RowTitular() {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 5),
      child: Row(
        children: [
          Text(
            "Nombre Titular: ",
            style: TextStyle(fontSize: 16),
          ),
          Text(
            "Pablo Agustin Rodriguez Diaz",
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }

  Row _rowButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          height: 50,
          child: ButtonApp(
            onPressed: _con.goToMyEvents,
            text: 'Tus eventos',
            color: utils.Colors.festiviaColor,
            textColor: Colors.white,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          height: 50,
          child: ButtonApp(
            onPressed: _con.goToEditProfile,
            text: 'Editar perfil',
            color: utils.Colors.festiviaColor,
            textColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buttonRegister() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 30, right: 30, bottom: 100),
      child: ButtonApp(
        onPressed: _con.logout,
        text: 'Cerrar sesión',
        color: utils.Colors.festiviaColor,
        textColor: Colors.white,
      ),
    );
  }

  Widget _bannerApp() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: _con.showAlertDialog,
          child: CircleAvatar(
            backgroundImage: _con.client.image != null
                ? NetworkImage(_con.client?.image)
                : AssetImage(
                    _con.imageFile?.path ?? 'assets/holder_profile.jpeg'),
            radius: 100,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            _con.client?.username ?? '',
            style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  void refresh() {
    setState(() {});
  }
}
