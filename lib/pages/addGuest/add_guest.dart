import 'package:festivia/pages/addArtist/add_artist_controller.dart';
import 'package:flutter/material.dart';

import 'package:festivia/widgets/button_app.dart';

import 'package:flutter/scheduler.dart';
import 'package:festivia/utils/colors.dart' as utils;

import 'add_guest_controller.dart';

class AddGuest extends StatefulWidget {
  @override
  State<AddGuest> createState() => _AddGuestState();
}

class _AddGuestState extends State<AddGuest> {
  AddGuestController _controller = AddGuestController();

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
      body: Center(
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _textFieldName(),
            _buttonRegister(),
          ],
        )),
      ),
    );
  }

  Widget _buttonRegister() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      child: ButtonApp(
        text: 'Agregar invitado',
        color: utils.Colors.festiviaColor,
        textColor: Colors.white,
        onPressed: _controller.addGuest,
      ),
    );
  }

  Widget _textFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        style: TextStyle(fontSize: 20),
        controller: _controller.nameGuest,
        decoration: InputDecoration(labelText: 'Nombre'),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
