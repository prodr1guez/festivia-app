import 'dart:io';

import 'package:festivia/api/env.dart';
import 'package:festivia/providers/auth_provider.dart';
import 'package:festivia/providers/event_provider.dart';
import 'package:festivia/providers/storage_provider.dart';
import 'package:festivia/utils/my_progress_dialog.dart';
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
  Position _position;

  places.GoogleMapsPlaces _places =
      places.GoogleMapsPlaces(apiKey: Env.GOOGLE_MAPS_API_KEY);

  TextEditingController tittleEvent = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController descriptionTicketFreeController =
      new TextEditingController();
  TextEditingController descriptionTicketGeneralController =
      new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  DropdownEditingController ageMinController =
      new DropdownEditingController<String>();

  DropdownEditingController maxTicketsFreeOrderController =
      new DropdownEditingController<String>();

  DropdownEditingController maxTicketsFreeEventController =
      new DropdownEditingController<String>();

  DropdownEditingController maxTicketsPaidOffController =
      new DropdownEditingController<String>();

  DropdownEditingController maxTicketsPaidOffEventController =
      new DropdownEditingController<String>();

  List<String> selectedGenders = [];

  LatLng fromLatLng;

  File imageFile;
  PickedFile pickedFile;
  String tittle;
  String dateStart;
  String dateStartParsed;
  String dateEnd;
  String dateEndParsed;

  String description;
  String ageMin;
  String dateEndFreePass;
  String dateEndFreePassParsed;
  String maxTicketsFreePass;
  String maxFreeTicketsOrder;
  String maxTicketsPaidOff;
  String maxTicketsPaidOffEvent;

  bool isFree = false;
  bool istimeLimit = false;

  bool isPaidOff = false;

  String price;

  String from;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _authProvider = new AuthProvider();
    _eventProvider = new EventProvider();
    _storageProvider = new StorageProvider();
    _geofireProvider = new GeofireProvider();
    _progressDialog =
        MyProgressDialog.createProgressDialog(context, 'Espere un momento...');
    refresh();
  }

  publish() async {
    tittle = tittleEvent.text;
    description = descriptionController.text;
    ageMin = ageMinController.value.toString();
    maxFreeTicketsOrder = maxTicketsFreeOrderController.value.toString();
    maxTicketsFreePass = maxTicketsFreeEventController.value.toString();
    maxTicketsPaidOff = maxTicketsPaidOffController.value.toString();
    maxTicketsPaidOffEvent = maxTicketsPaidOffEventController.value.toString();
    price = priceController.text;

    print(tittle);
    print("Fecha inicio");
    print(dateStart);
    print(dateStartParsed);
    print("fecha final");
    print(dateEnd);
    print(dateEndParsed);
    print("-----------");
    print(description);
    print("-----------");
    print(selectedGenders);
    print("-----------");
    print(ageMin);
    print("-----------");
    print(isFree);
    print(istimeLimit);
    print(dateEndFreePass);
    print(dateEndFreePassParsed);
    print(maxFreeTicketsOrder);
    print(maxTicketsFreePass);
    print("-----------");
    print(isPaidOff);
    print(price);
    print(maxTicketsPaidOff);
    print(maxTicketsPaidOffEvent);

    if (tittle.isEmpty) {
      print('debes ingresar todos los campos');
      utils.Snackbar.showSnackbar(
          context, key, 'Debes ingresar todos los campos');
      return;
    }
    _progressDialog.show();

    if (pickedFile == null) {
      print("Ingrese una foto");
      _progressDialog.hide();
    } else {
      TaskSnapshot snapshot = await _storageProvider.uploadFile(pickedFile);
      String imageUrl = await snapshot.ref.getDownloadURL();
      String idHost = _authProvider.getUser().uid;
      String id = MinId.getId('3{w}3{d}3{w}3{d}');

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
          isTimeLimit: istimeLimit,
          dateEndFreePass: dateEndFreePass,
          dateEndFreePassParsed: dateEndFreePassParsed,
          maxTicketsFreePass: maxTicketsFreePass,
          isPaidOff: isPaidOff,
          price: price,
          maxTicketsPaidOffEvent: maxTicketsPaidOffEvent,
          idHost: idHost,
          location: from,
          descriptionTicketFree: descriptionTicketFreeController.text,
          descriptionTicketGeneral: descriptionTicketGeneralController.text);

      await _eventProvider.create(event);
      saveLocation(id, dateEnd);
    }

    _progressDialog.hide();

    utils.Snackbar.showSnackbar(context, key, 'Se publicó el evento');
  }

  void showAlertDialog() {
    Widget galleryButton = FlatButton(
        onPressed: () {
          getImageFromGallery(ImageSource.gallery);
        },
        child: Text('GALERIA'));

    Widget cameraButton = FlatButton(
        onPressed: () {
          getImageFromGallery(ImageSource.camera);
        },
        child: Text('CAMARA'));

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona tu imagen'),
      actions: [galleryButton, cameraButton],
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
      print('No selecciono ninguna imagen');
    }
    Navigator.pop(context);
    refresh();
  }

  void saveLocation(String id, String end) async {
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
      print(p.description + "------");
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
              print(from + "-------");
              _position = Position(longitude: lng, latitude: lat);

              fromLatLng = new LatLng(lat, lng);
            }

            refresh();
          }
        }
      }
    }
  }
}
