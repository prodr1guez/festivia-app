import 'dart:io';

import 'package:festivia/api/env.dart';

import 'package:festivia/models/client.dart';
import 'package:festivia/providers/client_provider.dart';
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

class EditProfileController {
  Function refresh;
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  places.GoogleMapsPlaces _places =
      places.GoogleMapsPlaces(apiKey: Env.GOOGLE_MAPS_API_KEY);
  Client client = new Client();

  StorageProvider _storageProvider;
  AuthProvider _authProvider;
  ClientProvider _clientProvider;
  ProgressDialog _progressDialog;

  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  List<String> selectedGenders = [];

  String name;
  File imageFile;
  PickedFile pickedFile;
  String from;
  Position _position;
  LatLng fromLatLng;
  String currentImage = "";
  String idClient;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _authProvider = new AuthProvider();
    _clientProvider = new ClientProvider();
    _storageProvider = new StorageProvider();
    _progressDialog =
        MyProgressDialog.createProgressDialog(context, 'Espere un momento...');

    client = ModalRoute.of(context).settings.arguments as Client;

    nameController.text = client.username;
    phoneController.text = client.phone;
    currentImage = client.image;
    from = client.location;
    idClient = client.id;
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

    var username = nameController.text;
    var phone = phoneController.text;

    if (pickedFile != null) {
      TaskSnapshot snapshot =
          await _storageProvider.uploadProfileFile(pickedFile, client.id);
      String imageUrl = await snapshot.ref.getDownloadURL();

      var genders;
      if (selectedGenders.isNotEmpty) {
        genders = selectedGenders;
      } else {
        genders = client.genders;
      }

      Client client2 = Client(
          id: client.id,
          username: username,
          email: client.email,
          phone: phone,
          location: from,
          genders: genders,
          image: imageUrl);

      await _clientProvider.update(client2.toJson(), idClient);
      await _progressDialog.hide();
      utils.Snackbar.showSnackbar(context, key, 'Se actualizaron los datos');
      Navigator.pop(context);
    } else {
      var genders;
      if (selectedGenders.isNotEmpty) {
        genders = selectedGenders;
      } else {
        genders = client.genders;
      }
      Client client2 = Client(
          id: client.id,
          username: username,
          email: client.email,
          phone: phone,
          location: from,
          genders: genders,
          image: currentImage);

      try {
        await _clientProvider.update(client2.toJson(), idClient);
        await _progressDialog.hide();
        utils.Snackbar.showSnackbar(context, key, 'Se actualizaron los datos');
        Navigator.pop(context);
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
