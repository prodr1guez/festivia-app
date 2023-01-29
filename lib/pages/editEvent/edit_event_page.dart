import 'package:festivia/widgets/button_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:festivia/utils/colors.dart' as utils;

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/DateParsed.dart';
import 'edit_event_controller.dart';

class EditEventPage extends StatefulWidget {
  @override
  _EditEventPageState createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  EditEventController _controller = EditEventController();
  String dateStart;
  String dateStartParsed;
  String dateEnd;
  String dateEndParse;

  String dateEndFreePass;
  String dateEndFreePassParsed;

  bool _switchFreePass = false;
  bool _switchPassPaidOff = false;
  bool _switchFreePassLimitTime = false;

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
            _textEdit(),
            _addImage(),
            _textFieldName(),
            _cardGooglePlaces(),
            _textDescription(),
            _textFieldDescription(),
            _rowPassFree(),
            _sectionFreePass(context),
            _rowPassPaid(),
            _sectionPassPaid(context),
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

  Widget _textEdit() {
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

  Widget _textDescription() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
      child: Text(
        'Descripcion',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.normal, fontSize: 20),
      ),
    );
  }

  Widget _textFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _controller.tittleEvent,
        decoration: InputDecoration(labelText: 'Nombre del evento'),
      ),
    );
  }

  Widget _textFieldDescription() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 10 * 24.0,
      child: TextField(
        controller: _controller.descriptionController,
        maxLines: 10,
        decoration: InputDecoration(
          hintText: "Agregue informacion sobre su evento",
          filled: true,
        ),
      ),
    );
  }

  Widget _buttonRegister() {
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

  Row _rowPassFree() {
    return Row(
      children: [
        _textPassFree(),
        CupertinoSwitch(
          value: _switchFreePass,
          onChanged: (value) {
            setState(() {
              _switchFreePass = value;
              _controller.isFree = value;
            });
          },
        ),
      ],
    );
  }

  Row _rowPassPaid() {
    return Row(
      children: [
        _textPassPaid(),
        CupertinoSwitch(
          value: _switchPassPaidOff,
          onChanged: (value) {
            setState(() {
              _switchPassPaidOff = value;
              _controller.isGeneral = value;
            });
          },
        ),
      ],
    );
  }

  Widget _textPassFree() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
      child: Text(
        'Entrada Free',
        style: TextStyle(
            fontFamily: "Ubuntu",
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 20),
      ),
    );
  }

  Widget _textPassPaid() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20, right: 15, bottom: 10, top: 10),
      child: Text(
        'Entrada Paga',
        style: TextStyle(
            fontFamily: "Ubuntu",
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 20),
      ),
    );
  }

  Visibility _sectionFreePass(BuildContext context) {
    return Visibility(
      visible: _switchFreePass,
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: 350,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Con limite de hora",
                    style: TextStyle(
                      fontFamily: "Ubuntu",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: CupertinoSwitch(
                      value: _switchFreePassLimitTime,
                      onChanged: (value) {
                        setState(() {
                          _switchFreePassLimitTime = value;
                          _controller.istimeLimit = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: _switchFreePassLimitTime,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Hasta",
                      style: TextStyle(
                        fontFamily: "Ubuntu",
                      ),
                    )),
              ),
              Visibility(
                child: Column(
                  children: [DatePickerFreePass(context)],
                ),
                visible: _switchFreePassLimitTime,
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, right: 20),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Tickets maximos \n para el evento",
                          style: TextStyle(
                            fontFamily: "Ubuntu",
                          ),
                        )),
                  ),
                  _dropMaxEventTicketsFree()
                ],
              ),
              _textDescriptionTickets(),
              _textFieldDescriptionFree(),
            ],
          )),
    );
  }

  Visibility _sectionPassPaid(BuildContext context) {
    return Visibility(
      visible: _switchPassPaidOff,
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: 350,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Precio",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Ubuntu",
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 40,
                    margin: EdgeInsets.only(left: 10, right: 5),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _controller.priceController,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                        hintText: '0.0',
                      ),
                    ),
                  ),
                  Text("\$",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Ubuntu",
                      ))
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, right: 20),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Tickets maximos \n para el evento")),
                  ),
                  _dropMaxEventTicketsPaidOff()
                ],
              ),
              _textDescriptionTickets(),
              _textFieldDescriptionGeneral()
            ],
          )),
    );
  }

  ElevatedButton DatePickerFreePass(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          DatePicker.showDateTimePicker(context,
              locale: LocaleType.es, showTitleActions: true, onChanged: (date) {
            final dateString = DateParse().DiaConMes(date);
            final clockString = DateParse().Hora(date);
            dateEndFreePassParsed = dateString + " a las " + clockString;
            dateEndFreePass = date.toString();
          }, onConfirm: (date) {
            _controller.dateEndFreePassParsed = dateEndFreePassParsed;
            _controller.dateEndFreePass = dateEndFreePass;
            refresh();
          }, currentTime: DateTime.now());
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white)),
        child: Container(
          width: 300,
          child: Text(
            _controller.dateEndFreePassParsed == null
                ? 'DD/MM/AA HH:MM'
                : _controller.dateEndFreePassParsed,
            style: TextStyle(color: Colors.grey),
          ),
        ));
  }

  _dropMaxEventTicketsFree() {
    return Container(
        height: 55,
        width: 70,
        margin: EdgeInsets.only(top: 20),
        child: TextField(
          style: TextStyle(fontSize: 20),
          keyboardType: TextInputType.number,
          controller: _controller.maxTicketsFreeController,
        ));
  }

  Widget _textDescriptionTickets() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(bottom: 10, top: 10),
      child: Text(
        'Descripcion',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),
      ),
    );
  }

  Widget _textFieldDescriptionFree() {
    return Container(
      height: 10 * 10.0,
      child: TextField(
        controller: _controller.descriptionTicketFreeController,
        maxLines: 10,
        decoration: InputDecoration(
          hintText: "Detalles sobre esta entrada",
          filled: true,
        ),
      ),
    );
  }

  Widget _textFieldDescriptionGeneral() {
    return Container(
      height: 10 * 10.0,
      child: TextField(
        controller: _controller.descriptionTicketGeneralController,
        maxLines: 10,
        decoration: InputDecoration(
          hintText: "Detalles sobre esta entrada",
          filled: true,
        ),
      ),
    );
  }

  _dropMaxEventTicketsPaidOff() {
    return Container(
        height: 55,
        width: 70,
        margin: EdgeInsets.only(top: 20),
        child: TextField(
          style: TextStyle(fontSize: 20),
          keyboardType: TextInputType.number,
          controller: _controller.maxTicketsGeneralController,
        ));
  }

  void refresh() {
    setState(() {});
  }
}
