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
    print('INIT STATE');

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.key,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [_bannerApp(), _rowButtons()],
            ),
          ),
        ),
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
        )
      ],
    );
  }

  Widget _buttonRegister() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: ButtonApp(
        onPressed: _con.update,
        text: 'Actualizar ahora',
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
            backgroundImage: _con.imageFile != null
                ? AssetImage(_con.imageFile?.path ?? 'assets/place_holder.png')
                : _con.client?.image != null
                    ? NetworkImage(_con.client?.image)
                    : AssetImage(
                        _con.imageFile?.path ?? 'assets/place_holder.png'),
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

  Widget _textLogin() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Text(
        'Editar perfil',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
      ),
    );
  }

  Widget _textFieldUsername() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _con.usernameController,
        decoration: InputDecoration(
            hintText: 'Pepito Perez',
            labelText: 'Nombre de usuario',
            suffixIcon: Icon(
              Icons.person_outline,
              color: utils.Colors.festiviaColor,
            )),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
