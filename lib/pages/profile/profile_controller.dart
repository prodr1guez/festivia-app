import 'dart:io';
import 'package:flutter/services.dart';

import 'package:festivia/models/Like.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:festivia/models/client.dart';
import 'package:festivia/providers/auth_provider.dart';
import 'package:festivia/providers/client_provider.dart';
import 'package:festivia/providers/storage_provider.dart';
import 'package:festivia/utils/my_progress_dialog.dart';
import 'package:festivia/utils/snackbar.dart' as utils;
import 'package:festivia/utils/colors.dart' as utils;

import '../../widgets/button_app.dart';

class ProfileController {
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Function refresh;

  TextEditingController usernameController = new TextEditingController();

  AuthProvider _authProvider;
  ClientProvider _clientProvider;
  ProgressDialog _progressDialog;
  StorageProvider _storageProvider;
  List<Like> listlikes;
  bool haveLikes = false;

  PickedFile pickedFile;
  File imageFile;

  Client client =
      new Client(username: "", image: "", location: "", genders: []);

  Future init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;
    _authProvider = new AuthProvider();
    _clientProvider = new ClientProvider();
    _storageProvider = new StorageProvider();
    _progressDialog =
        MyProgressDialog.createProgressDialog(context, 'Espere un momento...');
    getUserInfo();
  }

  void getUserInfo() async {
    client = await _clientProvider.getById(_authProvider.getUser().uid);
    usernameController.text = client.username;
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

  void update() async {
    String username = usernameController.text;

    if (username.isEmpty) {
      utils.Snackbar.showSnackbar(
          context, key, 'Debes ingresar todos los campos');
      return;
    }
    _progressDialog.show();

    if (pickedFile == null) {
      Map<String, dynamic> data = {
        'image': client?.image ?? null,
        'username': username,
      };

      await _clientProvider.update(data, _authProvider.getUser().uid);
      _progressDialog.hide();
    } else {
      TaskSnapshot snapshot = await _storageProvider.uploadProfile(pickedFile);
      String imageUrl = await snapshot.ref.getDownloadURL();

      Map<String, dynamic> data = {
        'image': imageUrl,
        'username': username,
      };

      await _clientProvider.update(data, _authProvider.getUser().uid);
    }

    _progressDialog.hide();

    utils.Snackbar.showSnackbar(context, key, 'Los datos se actualizaron');
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

  void goToMyEvents() {
    Navigator.pushNamed(context, 'my_events');
  }

  void goToEditProfile() {
    Navigator.pushNamed(context, 'edit_profile', arguments: client);
  }

  openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Aviso",
                style: TextStyle(fontSize: 23, fontFamily: "Ubuntu")),
            content: Text(
              "Se eliminará la cuenta permanentemente, desea continuar?",
              style: TextStyle(fontSize: 17, fontFamily: "Ubuntu"),
            ),
            actions: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                child: ButtonApp(
                  onPressed: () => {
                    _progressDialog.show(),
                    deleteAccount(),
                    _progressDialog.hide()
                  },
                  text: 'Continuar',
                  color: utils.Colors.festiviaColor,
                  textColor: Colors.white,
                ),
              ),
            ],
          ));

  Future<void> logout() async {
    await _authProvider.signOut();
    Navigator.pushNamedAndRemoveUntil(context, 'start', (route) => false);
  }

  Future<List<Like>> getLikes() async {
    if (listlikes == null) {
      var likes = await _clientProvider.getLikes(_authProvider.getUser().uid);
      if (likes.isNotEmpty) {
        listlikes = likes;
        haveLikes = true;
        refresh();
      }
      return likes;
    }

    return listlikes;
  }

  Future<void> deleteAccount() async {
    await _authProvider.deleteAccount();
    Navigator.pushNamedAndRemoveUntil(context, 'start', (route) => false);
  }
}
