import 'dart:io';

import 'package:festivia/api/env.dart';
import 'package:festivia/models/Club.dart';
import 'package:festivia/models/UpdateInfoClub.dart';
import 'package:festivia/providers/club_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import '../../providers/auth_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as places;
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:festivia/utils/snackbar.dart' as utils;
import 'package:progress_dialog/progress_dialog.dart';

import '../../providers/storage_provider.dart';
import '../../utils/my_progress_dialog.dart';

class EditEventController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  places.GoogleMapsPlaces _places =
      places.GoogleMapsPlaces(apiKey: Env.GOOGLE_MAPS_API_KEY);
  Club club = new Club(
    id: "",
    name: "",
    image: "",
  );

  StorageProvider _storageProvider;
  AuthProvider _authProvider;
  ClubProvider _clubProvider;
  ProgressDialog _progressDialog;
  TextEditingController tittleEvent = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController maxTicketsFreeController = TextEditingController();
  TextEditingController descriptionTicketFreeController =
      TextEditingController();

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
  String idClub;

  bool isFree = false;
  bool istimeLimit = false;
  String dateEndFreePass;
  String dateEndFreePassParsed;
  bool isGeneral = false;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _authProvider = new AuthProvider();
    _clubProvider = new ClubProvider();
    _storageProvider = new StorageProvider();
    _progressDialog =
        MyProgressDialog.createProgressDialog(context, 'Espere un momento...');

    club = ModalRoute.of(context).settings.arguments as Club;
    tittleEvent.text = club.name;
    descriptionController.text = club.description;
    currentImage = club.image;
    fromLatLng = LatLng(club.lat, club.long);
    from = club.location;
    phoneController.text = club.phone;
    emailController.text = club.email;
    idClub = club.id;
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

    var tittle = tittleEvent.text;
    var description = descriptionController.text;
    var phone = phoneController.text;
    var email = emailController.text;

    if (pickedFile != null) {
      TaskSnapshot snapshot = await _storageProvider.uploadFile(pickedFile);
      String imageUrl = await snapshot.ref.getDownloadURL();

      UpdateInfoClub club = UpdateInfoClub(
          name: tittle,
          description: description,
          email: email,
          phone: phone,
          location: from,
          lat: fromLatLng.latitude,
          long: fromLatLng.longitude,
          image: imageUrl);

      await _clubProvider.update(club.toJson(), idClub);
      await _progressDialog.hide();
      utils.Snackbar.showSnackbar(context, key, 'Se actualizaron los datos');
    } else {
      UpdateInfoClub club = UpdateInfoClub(
          name: tittle,
          description: description,
          email: email,
          phone: phone,
          location: from,
          lat: fromLatLng.latitude,
          long: fromLatLng.longitude,
          image: currentImage);

      try {
        await _clubProvider.update(club.toJson(), idClub);
        await _progressDialog.hide();
        utils.Snackbar.showSnackbar(context, key, 'Se actualizaron los datos');
      } catch (e) {
        await _progressDialog.hide();
        utils.Snackbar.showSnackbar(
            context, key, "Ocurrió un error, vuelve a intentarlo mas tarde");
      }
    }
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
