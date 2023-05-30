import 'package:festivia/pages/add/add_controller.dart';
import 'package:festivia/pages/editClub/edit_club_controller.dart';
import 'package:festivia/utils/DateParsed.dart';
import 'package:festivia/widgets/button_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:festivia/utils/colors.dart' as utils;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'edit_profile_controller.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  EditProfileController _controller = EditProfileController();

  static List<String> _gendres = [
    "70s-80s",
    "90s-00s",
    "Indie",
    "Latino",
    "Reggaeton",
    "Electronica",
    "Techno",
    "Tech house",
    "Trap"
  ];

  final _items = _gendres
      .map((gender) => MultiSelectItem<String>(gender, gender))
      .toList();

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
            _textUpdate(),
            _addImage(),
            _textFieldName(),
            _cardGooglePlaces(),
            _textFieldPhone(),
            _textDropGenders(),
            _dropGenders(),
            _buttonUpdate(),
          ],
        )),
      ),
    );
  }

  Container _dropGenders() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: MultiSelectDialogField(
        items: _items,
        buttonText: Text("Seleccionar"),
        title: Text("Musica preferida"),
        listType: MultiSelectListType.CHIP,
        selectedColor: Colors.grey,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
        ),
        onConfirm: (results) {
          _controller.selectedGenders = results;
        },
      ),
    );
  }

  GestureDetector _addImage() {
    return GestureDetector(
      onTap: _controller.showAlertDialog,
      child: Container(
        height: 200,
        width: 250,
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image(
            image: _controller.imageFile == null
                ? AssetImage("assets/place_holder.png")
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

  Widget _textUpdate() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
      child: Text(
        'Editar datos',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
      ),
    );
  }

  Widget _textDropGenders() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
      child: Text(
        'Musica preferida',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.normal, fontSize: 20),
      ),
    );
  }

  Widget _textFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _controller.nameController,
        decoration: InputDecoration(labelText: 'Nombre'),
      ),
    );
  }

  Widget _textFieldPhone() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: _controller.phoneController,
        decoration: InputDecoration(labelText: 'Telefono de contacto'),
      ),
    );
  }

  Widget _buttonUpdate() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      child: ButtonApp(
        text: 'Actualizar',
        color: utils.Colors.festiviaColor,
        textColor: Colors.white,
        onPressed: _controller.publish,
      ),
    );
  }

  Widget _cardGooglePlaces() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _infoCardLocation('Ubicacion', _controller.from ?? 'Ubicacion',
                  () async {
                await _controller.showGoogleAutoComplete(true);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCardLocation(String title, String value, Function function) {
    return GestureDetector(
      onTap: function,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
            ),
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
