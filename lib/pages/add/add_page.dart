import 'package:festivia/models/PreSaleTicket.dart';
import 'package:festivia/pages/add/add_controller.dart';
import 'package:festivia/utils/DateParsed.dart';
import 'package:festivia/widgets/button_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:festivia/utils/colors.dart' as utils;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:dropdown_plus/dropdown_plus.dart';

import '../../models/PreSaleTickets.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  AddController _controller = AddController();

  String dateStart;
  String dateStartParsed;
  String dateEnd;
  String dateEndParse;

  String dateEndFreePass;
  String dateEndFreePassParsed;

  bool _switchFreePass = false;
  bool _switchPassPaidOff = false;
  bool _switchFreePassLimitTime = false;
  bool _switchPassPreSale = false;
  bool _switchEventInformativo = false;
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
            _textRegister(),
            _addImage(),
            _textFieldName(),
            _cardGooglePlaces(),
            _textDateStart(),
            DatePickerStart(context),
            _textDateEnd(),
            DatePickerEnd(context),
            _textDescription(),
            _textFieldDescription(),
            _textDropGenders(),
            _dropGenders(),
            _textTypeEvent(),
            _dropTypeEvent(),
            _textDropAge(),
            _dropAge(),
            Container(margin: EdgeInsets.only(top: 15), child: _rowPassFree()),
            _sectionFreePass(context),
            _rowPassPaid(),
            _sectionPassPaid(context),
            _rowPreSale(),
            _sectionPreSale(context),
            _rowOnlyEventInfo(),
            _buttonRegister(),
          ],
        )),
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
                          _switchPassPreSale = false;
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

  Visibility _sectionPreSale(BuildContext context) {
    return Visibility(
        visible: _switchPassPreSale,
        child: Column(children: [
          ..._controller.preSaleTicketsControllers
              .map((PreSaleTicket) => cardPreSale(PreSaleTicket)),
          _buttonAddPreSale(),
        ]));
  }

  Row _rowPassFree() {
    return Row(
      children: [
        _textPassFree(),
        Spacer(),
        Container(
          margin: EdgeInsets.only(right: 100),
          child: CupertinoSwitch(
            value: _switchFreePass,
            onChanged: (value) {
              setState(() {
                _switchFreePass = value;
                _switchPassPreSale = false;
                _switchEventInformativo = false;
                _controller.isFree = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Row _rowOnlyEventInfo() {
    return Row(
      children: [
        _textOnlyEventInfo(),
        Spacer(),
        Container(
          margin: EdgeInsets.only(right: 100),
          child: CupertinoSwitch(
            value: _switchEventInformativo,
            onChanged: (value) {
              setState(() {
                _switchEventInformativo = value;
                _switchPassPreSale = false;
                _switchPassPaidOff = false;
                _switchFreePass = false;
                _controller.isInformative = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Row _rowPassPaid() {
    return Row(
      children: [
        _textPassPaid(),
        Spacer(),
        Container(
          margin: EdgeInsets.only(right: 100),
          child: CupertinoSwitch(
            value: _switchPassPaidOff,
            onChanged: (value) {
              setState(() {
                _switchPassPaidOff = value;
                _switchPassPreSale = false;
                _switchEventInformativo = false;
                _controller.isGeneral = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Row _rowPreSale() {
    return Row(
      children: [
        _textPassPreSale(),
        Spacer(),
        Container(
          margin: EdgeInsets.only(right: 100),
          child: CupertinoSwitch(
            value: _switchPassPreSale,
            onChanged: (value) {
              setState(() {
                _switchPassPreSale = value;
                _switchPassPaidOff = false;
                _switchFreePass = false;
                _switchEventInformativo = false;
                _controller.isPreSale = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Container _dropGenders() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: MultiSelectDialogField(
        items: _items,
        buttonText: Text("Seleccionar"),
        title: Text("Géneros"),
        listType: MultiSelectListType.CHIP,
        selectedItemsTextStyle: TextStyle(color: Colors.white),
        selectedColor: Colors.black,
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

  _dropTypeEvent() {
    return Container(
      height: 55,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextDropdownFormField(
        controller: _controller.typeEventController,
        options: ["Fiesta", "After", "Previa", "Pool Party", "Sunset"],
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            suffixIcon: Icon(Icons.arrow_drop_down),
            labelText: "Tipo de evento"),
        dropdownHeight: 180,
      ),
    );
  }

  _dropAge() {
    return Container(
      height: 55,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextDropdownFormField(
        controller: _controller.ageMinController,
        options: [
          "14+",
          "16+",
          "18+",
          "19+",
          "20+",
          "21+",
          "22+",
          "23+",
          "24+",
          "25+"
        ],
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            suffixIcon: Icon(Icons.arrow_drop_down),
            labelText: "Edad"),
        dropdownHeight: 180,
      ),
    );
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

  ElevatedButton DatePickerStart(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          DatePicker.showDateTimePicker(context,
              locale: LocaleType.es, showTitleActions: true, onChanged: (date) {
            final dateString = DateParse().DiaConMes(date);
            final clockString = DateParse().Hora(date);
            dateStartParsed = dateString + " a las " + clockString;
            dateStart = date.toString();
          }, onConfirm: (date) {
            _controller.dateStart = dateStart;
            _controller.dateStartParsed = dateStartParsed;
            refresh();
          }, currentTime: DateTime.now());
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white)),
        child: Container(
          width: 300,
          child: Text(
            _controller.dateStartParsed == null
                ? 'DD/MM/AA HH:MM'
                : _controller.dateStartParsed,
            style: TextStyle(color: Colors.grey),
          ),
        ));
  }

  ElevatedButton DatePickerEnd(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          DatePicker.showDateTimePicker(context,
              locale: LocaleType.es, showTitleActions: true, onChanged: (date) {
            final dateString = DateParse().DiaConMes(date);
            final clockString = DateParse().Hora(date);
            dateEndParse = dateString + " a las " + clockString;
            dateEnd = date.toString();
          }, onConfirm: (date) {
            _controller.dateEnd = dateEnd;
            _controller.dateEndParsed = dateEndParse;
            refresh();
          }, currentTime: DateTime.now());
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white)),
        child: Container(
          width: 300,
          child: Text(
            _controller.dateEndParsed == null
                ? 'DD/MM/AA HH:MM'
                : _controller.dateEndParsed,
            style: TextStyle(color: Colors.grey),
          ),
        ));
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

  ElevatedButton DatePickerPreSaleStart(
      BuildContext context, PreSaleTickets controllers) {
    String dateStartPreSaleParsed;
    String dateStartPreSale;
    return ElevatedButton(
        onPressed: () {
          DatePicker.showDateTimePicker(context,
              locale: LocaleType.es, showTitleActions: true, onChanged: (date) {
            final dateString = DateParse().DiaConMes(date);
            final clockString = DateParse().Hora(date);
            dateStartPreSaleParsed = dateString + " a las " + clockString;
            dateStartPreSale = date.toString();
          }, onConfirm: (date) {
            controllers.dateStart = dateStartPreSale;
            controllers.dateStartParse = dateStartPreSaleParsed;
            refresh();
          }, currentTime: DateTime.now());
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white)),
        child: Container(
          width: 300,
          child: Text(
            controllers.dateStartParse == null
                ? 'DD/MM/AA HH:MM'
                : controllers.dateStartParse,
            style: TextStyle(color: Colors.grey),
          ),
        ));
  }

  ElevatedButton DatePickerPreSaleEnd(
      BuildContext context, PreSaleTickets controllers) {
    String dateEndPreSaleParsed;
    String dateEndPreSale;
    return ElevatedButton(
        onPressed: () {
          DatePicker.showDateTimePicker(context,
              locale: LocaleType.es, showTitleActions: true, onChanged: (date) {
            final dateString = DateParse().DiaConMes(date);
            final clockString = DateParse().Hora(date);
            dateEndPreSaleParsed = dateString + " a las " + clockString;
            dateEndPreSale = date.toString();
          }, onConfirm: (date) {
            controllers.dateEnd = dateEndPreSale;
            controllers.dateEndParsed = dateEndPreSaleParsed;
            refresh();
          }, currentTime: DateTime.now());
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white)),
        child: Container(
          width: 300,
          child: Text(
            controllers.dateEndParsed == null
                ? 'DD/MM/AA HH:MM'
                : controllers.dateEndParsed,
            style: TextStyle(color: Colors.grey),
          ),
        ));
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

  Widget _textRegister() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
      child: Text(
        'Crear evento',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 25,
          fontFamily: "Ubuntu",
        ),
      ),
    );
  }

  Widget _textDateStart() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
      child: Text(
        'Desde',
        style: TextStyle(
            fontFamily: "Ubuntu",
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 20),
      ),
    );
  }

  Widget _textDateEnd() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
      child: Text(
        'Hasta',
        style: TextStyle(
            fontFamily: "Ubuntu",
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 20),
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
            fontFamily: "Ubuntu",
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 20),
      ),
    );
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

  Widget _textDropGenders() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
      child: Text(
        'Géneros musicales',
        style: TextStyle(
            fontFamily: "Ubuntu",
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 20),
      ),
    );
  }

  Widget _textTypeEvent() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
      child: Text(
        'Tipo de evento',
        style: TextStyle(
            fontFamily: "Ubuntu",
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 20),
      ),
    );
  }

  Widget _textDropAge() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
      child: Text(
        'Edad minima',
        style: TextStyle(
            fontFamily: "Ubuntu",
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 20),
      ),
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

  Widget _textOnlyEventInfo() {
    return Container(
      width: 180,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
      child: Text(
        'Publicar como evento informativo  ',
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
        'Entrada General',
        style: TextStyle(
            fontFamily: "Ubuntu",
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 20),
      ),
    );
  }

  Widget _textPassPreSale() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20, right: 15, bottom: 10, top: 10),
      child: Text(
        'Preventas',
        style: TextStyle(
            fontFamily: "Ubuntu",
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 20),
      ),
    );
  }

  Widget _textFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _controller.tittleEvent,
        decoration: InputDecoration(labelText: 'Titulo del evento'),
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
          hintText: "Cuentale a la gente sobre su evento",
          filled: true,
        ),
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

  Visibility cardPreSale(PreSaleTickets controllers) {
    return Visibility(
        visible: true,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5.0,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Preventa Nº " + controllers.index.toString(),
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: "Ubuntu",
                          )),
                      Spacer(),
                      GestureDetector(
                          onTap: (() {
                            _controller.deleteTicketPreSale(controllers);
                          }),
                          child: Icon(Icons.close))
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Titulo:",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Ubuntu",
                        ),
                      ),
                      Container(
                        width: 200,
                        margin: EdgeInsets.only(left: 10),
                        child: TextField(
                          controller: controllers.tittle,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
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
                          margin: EdgeInsets.only(left: 10, right: 5),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: controllers.price,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(),
                              contentPadding:
                                  EdgeInsets.fromLTRB(15, 15, 15, 0),
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
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(children: [
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Cant de tickets: ",
                              style:
                                  TextStyle(fontSize: 18, fontFamily: "Ubuntu"),
                            )),
                      ),
                      Container(
                          width: 70,
                          child: TextField(
                            style:
                                TextStyle(fontSize: 18, fontFamily: "Ubuntu"),
                            keyboardType: TextInputType.number,
                            controller: controllers.numTickets,
                          ))
                    ]),
                  ),
                  Visibility(
                    visible: true,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Venta disponible desde:",
                          style: TextStyle(fontFamily: "Ubuntu", fontSize: 18),
                        )),
                  ),
                  Visibility(
                    child: Column(
                      children: [DatePickerPreSaleStart(context, controllers)],
                    ),
                    visible: true,
                  ),
                  Visibility(
                    visible: true,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Hasta:",
                          style: TextStyle(fontFamily: "Ubuntu", fontSize: 18),
                        )),
                  ),
                  Visibility(
                    child: Column(
                      children: [DatePickerPreSaleEnd(context, controllers)],
                    ),
                    visible: true,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(right: 20, bottom: 10, top: 20),
                    child: Text(
                      'Descripcion',
                      style: TextStyle(
                          fontFamily: "Ubuntu",
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 20),
                    ),
                  ),
                  Container(
                    height: 10 * 10.0,
                    child: TextField(
                      controller: controllers.description,
                      maxLines: 10,
                      decoration: InputDecoration(
                        hintText: "Detalles sobre esta entrada",
                        filled: true,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buttonAddPreSale() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: ButtonApp(
        text: 'Añadir entrada preventa',
        color: Colors.blue[200],
        textColor: Colors.white,
        onPressed: () => {_controller.checkPreSaleTickets(), refresh()},
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

  void refresh() {
    setState(() {});
  }
}
