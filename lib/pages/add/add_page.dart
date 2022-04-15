import 'package:festivia/pages/add/add_controller.dart';
import 'package:festivia/widgets/button_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:festivia/utils/colors.dart' as utils;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:dropdown_plus/dropdown_plus.dart';

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

  static List<String> _ages = [
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
  ];
  final _items = _gendres
      .map((gender) => MultiSelectItem<String>(gender, gender))
      .toList();

  final _itemsAges =
      _ages.map((age) => MultiSelectItem<String>(age, age)).toList();
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
            _textDropAge(),
            _dropAge(),
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
                  Text("Con limite de hora"),
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
                    alignment: Alignment.centerLeft, child: Text("Hasta")),
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
                        child: Text("Tickets maximos \n para el evento")),
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
                    style: TextStyle(fontSize: 18),
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
                  Text("\$", style: TextStyle(fontSize: 18))
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
              _controller.isPaidOff = value;
            });
          },
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

  _dropMaxOrderTicketsFree() {
    return Container(
      height: 55,
      width: 120,
      margin: EdgeInsets.only(top: 20),
      child: TextDropdownFormField(
        controller: _controller.maxTicketsFreeOrderController,
        options: [
          "1",
          "2",
          "3",
          "4",
          "5",
          "6",
          "7",
          "8",
          "9",
          "10",
          "11",
          "12",
          "13",
          "14",
          "15"
        ],
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            suffixIcon: Icon(Icons.arrow_drop_down),
            labelText: "Max Tickets"),
        dropdownHeight: 180,
      ),
    );
  }

  _dropMaxEventTicketsFree() {
    return Container(
      height: 55,
      width: 120,
      margin: EdgeInsets.only(top: 20),
      child: TextDropdownFormField(
        controller: _controller.maxTicketsFreeEventController,
        options: [
          "1",
          "2",
          "3",
          "4",
          "5",
          "6",
          "7",
          "8",
          "9",
          "10",
          "11",
          "12",
          "13",
          "14",
          "15"
        ],
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            suffixIcon: Icon(Icons.arrow_drop_down),
            labelText: "Max Tickets"),
        dropdownHeight: 180,
      ),
    );
  }

  _dropMaxEventTicketsPaidOff() {
    return Container(
      height: 55,
      width: 120,
      margin: EdgeInsets.only(top: 20),
      child: TextDropdownFormField(
        controller: _controller.maxTicketsPaidOffEventController,
        options: [
          "1",
          "2",
          "3",
          "4",
          "5",
          "6",
          "7",
          "8",
          "9",
          "10",
          "11",
          "12",
          "13",
          "14",
          "15"
        ],
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            suffixIcon: Icon(Icons.arrow_drop_down),
            labelText: "Max Tickets"),
        dropdownHeight: 180,
      ),
    );
  }

  _dropMaxOrderTicketsPaidOff() {
    return Container(
      height: 55,
      width: 120,
      margin: EdgeInsets.only(top: 10),
      child: TextDropdownFormField(
        controller: _controller.maxTicketsPaidOffController,
        options: [
          "1",
          "2",
          "3",
          "4",
          "5",
          "6",
          "7",
          "8",
          "9",
          "10",
          "11",
          "12",
          "13",
          "14",
          "15"
        ],
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            suffixIcon: Icon(Icons.arrow_drop_down),
            labelText: "Max Tickets"),
        dropdownHeight: 180,
      ),
    );
  }

  ElevatedButton DatePickerStart(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          DatePicker.showDateTimePicker(context,
              locale: LocaleType.es, showTitleActions: true, onChanged: (date) {
            print('change $date in time zone ' +
                date.timeZoneOffset.inHours.toString());
            initializeDateFormatting('es_ES', null);
            final dateTime = DateTime.parse(date.toString());
            final formatTime = DateFormat('HH:mm a');
            final formatDate = DateFormat('EEE, M/d/y');
            final clockString = formatTime.format(dateTime);
            final DateString = DateFormat.yMMMMd('es_AR').format(dateTime);
            dateStartParsed = DateString + " a las " + clockString;
            dateStart = date.toString();
            print(DateFormat('yyyy-MM-dd – kk:mm').format(dateTime));
            print("asd");
          }, onConfirm: (date) {
            _controller.dateStart = dateStart;
            _controller.dateStartParsed = dateStartParsed;
            refresh();
          }, currentTime: DateTime(2022, 1, 1, 24, 00, 34));
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
            print('change $date in time zone ' +
                date.timeZoneOffset.inHours.toString());
            initializeDateFormatting('es_ES', null);
            final dateTime = DateTime.parse(date.toString());
            final formatTime = DateFormat('HH:mm a');
            final formatDate = DateFormat('EEE, M/d/y');
            final clockString = formatTime.format(dateTime);
            final DateString = DateFormat.yMMMMd('es_AR').format(dateTime);
            dateEndParse = DateString + " a las " + clockString;
            dateEnd = date.toString();
          }, onConfirm: (date) {
            _controller.dateEnd = dateEnd;
            _controller.dateEndParsed = dateEndParse;
            refresh();
          }, currentTime: DateTime(2022, 1, 1, 24, 00, 34));
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
            print('change $date in time zone ' +
                date.timeZoneOffset.inHours.toString());
            initializeDateFormatting('es_ES', null);
            final dateTime = DateTime.parse(date.toString());
            final formatTime = DateFormat('HH:mm a');
            final formatDate = DateFormat('EEE, M/d/y');
            final clockString = formatTime.format(dateTime);
            final DateString = DateFormat.yMMMMd('es_AR').format(dateTime);
            dateEndFreePassParsed = DateString + " a las " + clockString;
            dateEndFreePass = date.toString();
          }, onConfirm: (date) {
            _controller.dateEndFreePassParsed = dateEndFreePassParsed;
            _controller.dateEndFreePass = dateEndFreePass;
            refresh();
          }, currentTime: DateTime(2022, 1, 1, 24, 00, 34));
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
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
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
            color: Colors.black, fontWeight: FontWeight.normal, fontSize: 20),
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
            color: Colors.black, fontWeight: FontWeight.normal, fontSize: 20),
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
            color: Colors.black, fontWeight: FontWeight.normal, fontSize: 20),
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
            color: Colors.black, fontWeight: FontWeight.normal, fontSize: 20),
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
            color: Colors.black, fontWeight: FontWeight.normal, fontSize: 20),
      ),
    );
  }

  Widget _textPassPaid() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
      child: Text(
        'Entrada Paga',
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
        text: 'Publicar',
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

  void refresh() {
    setState(() {});
  }
}
