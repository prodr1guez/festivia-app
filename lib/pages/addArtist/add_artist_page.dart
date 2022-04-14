import 'package:festivia/pages/addArtist/add_artist_controller.dart';
import 'package:flutter/material.dart';
import 'package:festivia/pages/add/add_controller.dart';
import 'package:festivia/widgets/button_app.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/scheduler.dart';
import 'package:festivia/utils/colors.dart' as utils;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:dropdown_plus/dropdown_plus.dart';

class AddArtist extends StatefulWidget {
  @override
  State<AddArtist> createState() => _AddArtistState();
}

class _AddArtistState extends State<AddArtist> {
  AddArtistController _controller = AddArtistController();

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
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            _addImage(),
            _textFieldName(),
            _buttonRegister(),
          ],
        )),
      ),
    );
  }

  GestureDetector _addImage() {
    return GestureDetector(
      onTap: _controller.showAlertDialog,
      child: Container(
        height: 200,
        width: 350,
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image(
            image: _controller.imageFile == null
                ? AssetImage(
                    _controller.imageFile?.path ?? "assets/place_holder.png")
                : FileImage(_controller.imageFile),
            fit: BoxFit.cover,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
        ),
      ),
    );
  }

  Widget _buttonRegister() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      child: ButtonApp(
        text: 'Publicar',
        color: utils.Colors.festiviaColor,
        textColor: Colors.white,
        onPressed: _controller.publish,
      ),
    );
  }

  Widget _textFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _controller.nameArtist,
        decoration: InputDecoration(labelText: 'Titulo del evento'),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
