import 'dart:io';

import 'package:festivia/api/env.dart';
import 'package:festivia/models/PreSaleTicket.dart';
import 'package:festivia/providers/auth_provider.dart';
import 'package:festivia/providers/event_provider.dart';
import 'package:festivia/providers/pre_sale_tickets_provider.dart';
import 'package:festivia/providers/storage_provider.dart';
import 'package:festivia/utils/my_progress_dialog.dart';
import 'package:festivia/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:festivia/utils/snackbar.dart' as utils;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_maps_webservice/places.dart' as places;
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

import 'package:min_id/min_id.dart';
import '../../models/Event.dart';
import '../../models/PreSaleTickets.dart';
import '../../providers/geofire_provider.dart';

class AddController {
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Function refresh;
  ProgressDialog _progressDialog;
  AuthProvider _authProvider;
  EventProvider _eventProvider;
  StorageProvider _storageProvider;
  GeofireProvider _geofireProvider;
  PreSaleTicketsProvider _preSaleTicketsProvider;
  SharedPref _sharedPref;
  Position _position;

  final List<PreSaleTickets> preSaleTicketsControllers = <PreSaleTickets>[];
  List<PreSaleTicket> preSaleTickets = <PreSaleTicket>[];

  var tittlePreSaleList = <TextEditingController>[];

  places.GoogleMapsPlaces _places =
      places.GoogleMapsPlaces(apiKey: Env.GOOGLE_MAPS_API_KEY);

  TextEditingController tittleEvent = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController descriptionTicketFreeController =
      TextEditingController();
  TextEditingController descriptionTicketGeneralController =
      TextEditingController();
  TextEditingController priceController = TextEditingController();
  DropdownEditingController ageMinController =
      DropdownEditingController<String>();

  DropdownEditingController typeEventController =
      DropdownEditingController<String>();

  TextEditingController maxTicketsFreeController = TextEditingController();

  TextEditingController maxTicketsGeneralController = TextEditingController();

  List<String> selectedGenders = [];

  LatLng fromLatLng;

  File imageFile;
  PickedFile pickedFile;
  String tittle;
  String dateStart;
  String dateStartParsed;
  String dateEnd;
  String dateEndParsed;

  String maxTicketFree = "0";
  String maxTicketsPaid = "0";

  String description;
  String ageMin;

  String dateEndFreePass;
  String dateEndFreePassParsed;

  String dateStartPreSale;
  String dateStartPreSaleParsed;

  int maxTicketsFreePass;
  String maxFreeTicketsOrder;
  String maxTicketsPaidOff;
  int maxTicketsPaidOffEvent;
  String typeEvent;

  bool isFree = false;
  bool isInformative = false;
  bool istimeLimit = false;

  bool isGeneral = false;
  bool isPreSale = false;

  String price;

  String from;
  String typeUser;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _authProvider = new AuthProvider();
    _eventProvider = new EventProvider();
    _storageProvider = new StorageProvider();
    _geofireProvider = new GeofireProvider();
    _preSaleTicketsProvider = new PreSaleTicketsProvider();
    _sharedPref = new SharedPref();
    typeUser = await _sharedPref.read("typeUser");
    _progressDialog =
        MyProgressDialog.createProgressDialog(context, 'Espere un momento...');

    refresh();
  }

  publish() async {
    if (tittleEvent.text.isEmpty ||
        from == null ||
        dateStart == null ||
        dateEnd == null ||
        descriptionController.text.isEmpty ||
        ageMinController.value == null) {
      utils.Snackbar.showSnackbar(
          context, key, 'Debes ingresar todos los campos');
      return;
    }

    if (!isInformative) {
      if (!isFree && !isGeneral && preSaleTicketsControllers.isEmpty) {
        utils.Snackbar.showSnackbar(
            context, key, 'Debes seleccionar al menos un tipo de entrada');
        return;
      }

      if (isFree) {
        if (maxTicketsFreeController.value.text.isEmpty) {
          utils.Snackbar.showSnackbar(context, key,
              'Debes seleccionar cantidad de entradas para el evento');
          return;
        }

        if (descriptionTicketFreeController.value.text.isEmpty) {
          utils.Snackbar.showSnackbar(context, key,
              'Debes completar una descripcion para las entradas');
          return;
        }
      } else {
        maxTicketsFreeController.text = "0";
      }

      if (isGeneral) {
        if (priceController.text.isEmpty) {
          utils.Snackbar.showSnackbar(
              context, key, 'Debes seleccionar un precio para las entradas');
          return;
        }
        if (maxTicketsGeneralController.value.text.isEmpty) {
          utils.Snackbar.showSnackbar(context, key,
              'Debes seleccionar cantidad de entradas para el evento');
          return;
        }

        if (descriptionTicketGeneralController.value.text.isEmpty) {
          utils.Snackbar.showSnackbar(context, key,
              'Debes completar una descripcion para las entradas');
          return;
        }
      } else {
        maxTicketsGeneralController.text = "0";
      }
    } else {
      maxTicketsGeneralController.text = "0";
      maxTicketsFreeController.text = "0";
    }

    if (typeEventController.value == null) {
      typeEventController.value = "Fiesta";
    }

    if (maxTicketsFreeController.value.text.isEmpty != null) {
      maxTicketFree = maxTicketsFreeController.value.text.toString();
      maxTicketsFreePass = int.parse(maxTicketFree);
    }

    if (maxTicketsGeneralController.value.text != null) {
      maxTicketsPaid = maxTicketsGeneralController.value.text.toString();
    }

    tittle = tittleEvent.text;
    description = descriptionController.text;
    ageMin = ageMinController.value.toString();
    maxFreeTicketsOrder = maxTicketsFreeController.value.toString();

    maxTicketsPaidOff = maxTicketsGeneralController.value.toString();
    maxTicketsPaidOffEvent = int.parse(maxTicketsPaid);
    price = priceController.text;
    typeEvent = typeEventController.value.toString();

    await _progressDialog.show();

    if (pickedFile == null) {
      utils.Snackbar.showSnackbar(context, key, 'Debes seleccionar una foto');
      return _progressDialog.hide();
    } else {
      TaskSnapshot snapshot = await _storageProvider.uploadFile(pickedFile);
      String imageUrl = await snapshot.ref.getDownloadURL();
      String idHost = _authProvider.getUser().uid;
      String id = MinId.getId('3{w}3{d}3{w}3{d}');

      addPreSaleTickets();

      Event event = Event(
          id: id,
          image: imageUrl,
          tittle: tittle,
          dateStart: dateStart,
          dateStartParsed: dateStartParsed,
          dateEnd: dateEnd,
          dateEndParsed: dateEndParsed,
          description: description,
          genders: selectedGenders,
          ageMin: ageMin,
          isFree: isFree,
          isInformative: isInformative,
          isTimeLimit: istimeLimit,
          dateEndFreePass: dateEndFreePass,
          dateEndFreePassParsed: dateEndFreePassParsed,
          maxTicketsFreePass: maxTicketsFreePass,
          assistants: 0,
          freeTicketsSold: 0,
          ticketsSold: 0,
          revenue: 0,
          vipTicketsSold: 0,
          isPaidOff: isGeneral,
          price: price,
          maxTicketsPaidOffEvent: maxTicketsPaidOffEvent,
          idHost: idHost,
          location: from,
          lat: _position.latitude,
          long: _position.longitude,
          descriptionTicketFree: descriptionTicketFreeController.text,
          descriptionTicketGeneral: descriptionTicketGeneralController.text,
          typeHost: typeUser,
          typeEvent: typeEvent,
          promoted: false);

      try {
        await _eventProvider.create(event);
        await savePreSaleTicket(id);
        await saveLocation(id, dateEnd);
      } catch (error) {
        utils.Snackbar.showSnackbar(
            context, key, 'No se pudo crear el evento, Error: $error');
      }
    }
    await _progressDialog.hide();

    if (typeUser == "club") {
      navigateToCongratsClub(context);
      return;
    }
    navigateToCongrats(context);
  }

  void showAlertDialog() {
    Widget galleryButton = FlatButton(
        onPressed: () {
          getImageFromGallery(ImageSource.gallery);
        },
        child: Text('GALERIA'));

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona tu imagen'),
      actions: [galleryButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  Future getImageFromGallery(ImageSource imageSource) async {
    pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    } else {
      utils.Snackbar.showSnackbar(context, key, 'No selecciono ninguna imagen');
    }
    Navigator.pop(context);
    refresh();
  }

  saveLocation(String id, String end) async {
    await _geofireProvider.create(
        id, _position.latitude, _position.longitude, dateEnd);
    _progressDialog.hide();
  }

  Future<Null> showGoogleAutoComplete(bool isFrom) async {
    places.Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: Env.GOOGLE_MAPS_API_KEY,
      language: 'es',
      radius: 5000,
    );

    if (p != null) {
      places.PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId, language: 'es');
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      List<Address> address =
          await Geocoder.local.findAddressesFromQuery(p.description);
      if (address != null) {
        if (address.length > 0) {
          if (detail != null) {
            String direction = detail.result.name;
            String city = address[0].locality;
            String department = address[0].adminArea;

            if (isFrom) {
              from = '$direction, $city, $department';

              _position = Position(longitude: lng, latitude: lat);

              fromLatLng = new LatLng(lat, lng);
            }

            refresh();
          }
        }
      }
    }
  }

  navigateToCongrats(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, 'congrats_event', (route) => false);
  }

  navigateToCongratsClub(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, 'congrats_event_club', (route) => false);
  }

  checkIndexPreSaleTickets() {
    if (preSaleTicketsControllers.isNotEmpty) {
      var index = 0;

      for (var ticket in preSaleTicketsControllers) {
        index++;
        ticket.index = index;
      }
    }
  }

  deleteTicketPreSale(PreSaleTickets index) {
    preSaleTicketsControllers.remove(index);
    checkIndexPreSaleTickets();
    refresh();
  }

  checkPreSaleTickets() {
    if (preSaleTicketsControllers.isNotEmpty) {
      for (var ticket in preSaleTicketsControllers) {
        if (ticket.tittle.text.isEmpty ||
            ticket.price.text.isEmpty ||
            ticket.numTickets.text.isEmpty ||
            ticket.dateStart == null ||
            ticket.dateEnd == null ||
            ticket.description.text.isEmpty) {
          utils.Snackbar.showSnackbar(context, key,
              'Debes completar todos los datos de las entradas para preventa');
          return false;
        }
      }
    }

    preSaleTicketsControllers.add(PreSaleTickets(
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController()));

    checkIndexPreSaleTickets();

    refresh();
  }

  void addPreSaleTickets() {
    for (var ticket in preSaleTicketsControllers) {
      preSaleTickets.add(PreSaleTicket(
          id: MinId.getId('3{w}3{d}3{w}3{d}'),
          tittle: ticket.tittle.text,
          price: ticket.price.text,
          dateStart: ticket.dateStart,
          dateEnd: ticket.dateEnd,
          numTickets: int.parse(ticket.numTickets.text),
          description: ticket.description.text));
    }
  }

  savePreSaleTicket(String id) async {
    await _preSaleTicketsProvider.addPreSaleTickets(preSaleTickets, id);
  }
}
