import 'dart:io';

import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:festivia/api/env.dart';
import 'package:festivia/models/HostEvent.dart';
import 'package:festivia/models/UpdateInfoClub.dart';
import 'package:festivia/providers/client_provider.dart';
import 'package:festivia/providers/event_provider.dart';
import 'package:festivia/providers/geofire_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import '../../models/Event.dart';
import '../../providers/auth_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as places;
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:festivia/utils/snackbar.dart' as utils;
import 'package:progress_dialog/progress_dialog.dart';

import '../../providers/storage_provider.dart';
import '../../utils/DateParsed.dart';
import '../../utils/my_progress_dialog.dart';

class EditEventController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  places.GoogleMapsPlaces _places =
      places.GoogleMapsPlaces(apiKey: Env.GOOGLE_MAPS_API_KEY);
  Event event = new Event(
    id: "",
    tittle: "",
    image: "",
  );

  StorageProvider _storageProvider;
  AuthProvider _authProvider;
  EventProvider _eventProvider;
  ClientProvider _clientProvider;
  GeofireProvider _geofireProvider;
  ProgressDialog _progressDialog;
  TextEditingController tittleEventController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  DropdownEditingController typeEventController =
      DropdownEditingController<String>();
  TextEditingController maxTicketsFreeController = TextEditingController();
  TextEditingController descriptionTicketFreeController =
      TextEditingController();

  DropdownEditingController ageMinController =
      DropdownEditingController<String>();

  TextEditingController descriptionTicketGeneralController =
      TextEditingController();

  TextEditingController maxTicketsGeneralController = TextEditingController();

  TextEditingController priceController = TextEditingController();
  List<String> selectedGenders = [];
  String idEvent;
  File imageFile;
  PickedFile pickedFile;
  String from;
  Position _position;
  LatLng fromLatLng;
  String currentImage = "";

  bool isFree = false;
  bool istimeLimit = false;
  String dateEndFreePass;
  String dateEndFreePassParsed;
  bool isGeneral = false;
  String typeEvent;
  String dateStart;
  String dateStartParsed = "";
  String dateEndParsed = "";
  String dateEnd;
  String ageMin;
  String tittle;
  String description;
  bool showEditTickets;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _authProvider = new AuthProvider();
    _eventProvider = new EventProvider();
    _storageProvider = new StorageProvider();
    _clientProvider = new ClientProvider();
    _geofireProvider = new GeofireProvider();
    _progressDialog =
        MyProgressDialog.createProgressDialog(context, 'Espere un momento...');

    event = ModalRoute.of(context).settings.arguments as Event;
    _position = Position(longitude: event.long, latitude: event.lat);

    tittleEventController.text = event.tittle;
    currentImage = event.image;
    fromLatLng = LatLng(event.lat, event.long);
    from = event.location;
    dateStart = event.dateStart;
    typeEvent = event.typeEvent;
    selectedGenders = event.genders;
    dateEnd = event.dateEnd;
    descriptionController.text = event.description;

    dateStartParsed = DateParse().DiaConMes(DateTime.parse(event.dateStart)) +
        " a las " +
        DateParse().Hora(DateTime.parse(event.dateStart));

    dateEndParsed = DateParse().DiaConMes(DateTime.parse(event.dateEnd)) +
        " a las " +
        DateParse().Hora(DateTime.parse(event.dateEnd));

    showEditTickets = !event.isInformative;
    idEvent = event.id;
    refresh();
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
      utils.Snackbar.showSnackbar(context, key, 'No selecciono ninguna imagen');
    }
    Navigator.pop(context);
    refresh();
  }

  publish() async {
    await _progressDialog.show();

    if (typeEventController.value != null) {
      typeEvent = typeEventController.value.toString();
    }
    if (ageMinController.value != null) {
      ageMin = ageMinController.value.toString();
    }

    if (descriptionController.value != null) {
      description = descriptionController.value.text;
    }

    if (tittleEventController.value != null) {
      tittle = tittleEventController.value.text;
    }

    if (pickedFile != null) {
      TaskSnapshot snapshot = await _storageProvider.uploadFile(pickedFile);
      String imageUrl = await snapshot.ref.getDownloadURL();

      event.tittle = tittle;
      event.description = description;
      event.location = from;
      event.dateStart = dateStart;
      event.dateEnd = dateEnd;
      event.genders = selectedGenders;
      event.typeEvent = typeEvent;
      event.lat = fromLatLng.latitude;
      event.long = fromLatLng.longitude;
      event.image = imageUrl;

      HostEvent hostEvent = new HostEvent(
          id: event.id,
          image: currentImage,
          name: event.tittle,
          dateEnd: event.dateEnd,
          location: event.location);

      await _eventProvider.update(event.toJson(), idEvent);
      await _clientProvider.updateClientEvent(
          hostEvent.toJson(), _authProvider.getUser().uid, event.id);
      await updateLocation(event.id, event.dateEnd);
      await _progressDialog.hide();
      utils.Snackbar.showSnackbar(context, key, 'Se actualizaron los datos');
    } else {
      event.tittle = tittle;
      event.description = description;
      event.location = from;
      event.dateStart = dateStart;
      event.dateEnd = dateEnd;
      event.genders = selectedGenders;
      event.typeEvent = typeEvent;
      event.lat = fromLatLng.latitude;
      event.long = fromLatLng.longitude;
      event.image = currentImage;

      HostEvent hostEvent = new HostEvent(
          id: event.id,
          image: currentImage,
          name: event.tittle,
          dateEnd: event.dateEnd,
          location: event.location);

      try {
        await _eventProvider.update(event.toJson(), idEvent);

        await _clientProvider.updateClientEvent(
            hostEvent.toJson(), _authProvider.getUser().uid, event.id);
        await updateLocation(event.id, event.dateEnd);
        await _progressDialog.hide();
        utils.Snackbar.showSnackbar(context, key, 'Se actualizaron los datos');
      } catch (e) {
        await _progressDialog.hide();
        utils.Snackbar.showSnackbar(
            context, key, "Ocurrió un error, vuelve a intentarlo mas tarde");
      }
    }
  }

  updateLocation(String id, String end) async {
    await _geofireProvider.update(
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
}
