import 'dart:io';

import 'package:festivia/models/ArtistImage.dart';

import 'package:festivia/providers/image_artist_provider.dart';
import 'package:festivia/providers/storage_provider.dart';
import 'package:festivia/utils/my_progress_dialog.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:festivia/utils/snackbar.dart' as utils;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:geolocator/geolocator.dart';

import '../../providers/geofire_provider.dart';

class AddArtistController {
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Function refresh;
  ProgressDialog _progressDialog;
  ImageArtistProvider _artistImageProvider;
  StorageProvider _storageProvider;
  GeofireProvider _geofireProvider;
  Position _position;

  File imageFile;
  PickedFile pickedFile;

  TextEditingController nameArtist = new TextEditingController();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    _artistImageProvider = new ImageArtistProvider();
    _storageProvider = new StorageProvider();
    _geofireProvider = new GeofireProvider();
    _progressDialog =
        MyProgressDialog.createProgressDialog(context, 'Espere un momento...');
    refresh();
  }

  publish() async {
    if (pickedFile == null) {
      utils.Snackbar.showSnackbar(context, key, 'No selecciono ninguna imagen');
      _progressDialog.hide();
    } else {
      TaskSnapshot snapshot =
          await _storageProvider.uploadArtistImage(pickedFile);
      String imageUrl = await snapshot.ref.getDownloadURL();

      ArtistImage artistImage =
          ArtistImage(name: nameArtist.text, url: imageUrl);
      await _artistImageProvider.create(artistImage);
    }

    _progressDialog.hide();

    utils.Snackbar.showSnackbar(context, key, 'Se subio la foto');
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
}
