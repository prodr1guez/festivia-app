import 'dart:io';

import 'package:festivia/models/ArtistImage.dart';
import 'package:festivia/models/Ticket.dart';
import 'package:festivia/providers/event_provider.dart';

import 'package:festivia/providers/image_artist_provider.dart';
import 'package:festivia/providers/storage_provider.dart';
import 'package:festivia/utils/my_progress_dialog.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:festivia/utils/snackbar.dart' as utils;
import 'package:min_id/min_id.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:geolocator/geolocator.dart';

import '../../models/Event.dart';
import '../../providers/geofire_provider.dart';

class AddGuestController {
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Function refresh;
  ProgressDialog _progressDialog;
  EventProvider _eventProvider;

  File imageFile;
  PickedFile pickedFile;
  var arguments;
  var idEvent;

  TextEditingController nameGuest = new TextEditingController();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _eventProvider = EventProvider();
    arguments = ModalRoute.of(context).settings.arguments as Map;

    idEvent = arguments["idEvent"];
    _progressDialog =
        MyProgressDialog.createProgressDialog(context, 'Espere un momento...');
    refresh();
  }

  addGuest() async {
    if (nameGuest.text.isNotEmpty) {
      Event event = await _eventProvider.getById(idEvent);
      String ticketId = MinId.getId('3{w}3{d}').toUpperCase();
      Ticket ticket = Ticket(
          name: nameGuest.text,
          type: "Invitado",
          ticketId: ticketId,
          checkedIn: false,
          location: event.location,
          date: event.dateStartParsed,
          nameEvent: event.tittle);

      try {
        await _eventProvider.addTicketInEvent(ticket, idEvent);
        await _eventProvider.addGuest(ticket, idEvent);
        _progressDialog.hide();
        utils.Snackbar.showSnackbar(
            context, key, 'Se agregó el invitado correctamente');
        nameGuest.clear();
      } catch (e) {
        utils.Snackbar.showSnackbar(
            context, key, 'Hubo un error, inténtalo nuevamente');
      }
    } else {
      utils.Snackbar.showSnackbar(context, key, 'Debes ingresar un nombre');
    }
  }
}
