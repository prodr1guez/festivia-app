import 'dart:io';

import 'package:festivia/api/env.dart';
import 'package:festivia/models/Club.dart';
import 'package:festivia/models/User.dart';
import 'package:festivia/providers/club_provider.dart';
import 'package:festivia/providers/user_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import '../../providers/auth_provider.dart';
import '../../providers/event_provider.dart';
import '../../providers/geofire_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as places;
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:festivia/utils/snackbar.dart' as utils;
import 'package:progress_dialog/progress_dialog.dart';

import '../../providers/storage_provider.dart';
import '../../utils/my_progress_dialog.dart';

class RegisterClubController {
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
  UserProvider _userProvider;

  ProgressDialog _progressDialog;
  TextEditingController tittleEvent = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController confirmPassController = new TextEditingController();
  List<String> selectedGenders = [];
  String idEvent;
  File imageFile;
  PickedFile pickedFile;
  String from;
  Position _position;
  LatLng fromLatLng;
  String currentImage = "";

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _authProvider = new AuthProvider();
    _clubProvider = new ClubProvider();
    _userProvider = new UserProvider();
    _storageProvider = new StorageProvider();
    _progressDialog =
        MyProgressDialog.createProgressDialog(context, 'Espere un momento...');

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
      print('No selecciono ninguna imagen');
    }
    Navigator.pop(context);
    refresh();
  }

  publish() async {
    var tittle = tittleEvent.text;
    var description = descriptionController.text;
    var phone = phoneController.text;
    var email = emailController.text;
    var pass = passController.text;

    if (pickedFile != null) {
      await _progressDialog.show();
      print("entandinf");
      TaskSnapshot snapshot = await _storageProvider.uploadFile(pickedFile);
      String imageUrl = await snapshot.ref.getDownloadURL();

      bool isRegister = await _authProvider.register(email, pass);

      String userId = _authProvider.getUser().uid;

      Club club = Club(
          id: userId,
          name: tittle,
          description: description,
          email: email,
          phone: phone,
          location: from,
          lat: fromLatLng.latitude,
          long: fromLatLng.longitude,
          image: imageUrl);

      if (isRegister) {
        await _clubProvider.create(club);
        await _userProvider.create(User(id: userId, type: "club"));

        _progressDialog.hide();
        utils.Snackbar.showSnackbar(
            context, key, 'El usuario se registro correctamente');

        Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
      } else {
        _progressDialog.hide();
        print('El usuario no se pudo registrar');
      }
    } else {
      utils.Snackbar.showSnackbar(context, key, 'Seleccione una foto');
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
