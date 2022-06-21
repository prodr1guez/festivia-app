import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festivia/models/Event.dart';
import 'package:festivia/models/HostEvent.dart';
import 'package:festivia/models/Ticket.dart';
import 'package:festivia/providers/auth_provider.dart';
import 'package:festivia/providers/client_provider.dart';
import 'package:min_id/min_id.dart';

import '../models/Club.dart';

class ClubProvider {
  CollectionReference _ref;
  ClientProvider _clientProvider = new ClientProvider();
  AuthProvider _authProvider = new AuthProvider();

  ClubProvider() {
    _ref = FirebaseFirestore.instance.collection('Clubs');
  }

  Future<void> create(Event event) {
    String errorMessage;

    try {
      _ref.doc(event.id).set(event.toJson());

      HostEvent eventHost =
          HostEvent(id: event.id, image: event.image, name: event.tittle);
      _clientProvider.addEvent(
          eventHost.toJson(), _authProvider.getUser().uid, event.id);
    } catch (error) {
      errorMessage = error.toString();
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
  }

  Future<Club> getById(String id) async {
    DocumentSnapshot document = await _ref.doc("GJmOjrJQCXCnhs3zhdNF").get();

    if (document.exists) {
      Club club = Club.fromJson(document.data());
      return club;
    }

    return null;
  }

  Future<void> addTicketInEvent(Ticket ticket, String idEvent) async {
    String errorMessage;
    try {
      _ref
          .doc(idEvent)
          .collection("tickets")
          .doc(ticket.ticketId)
          .set(ticket.toJson());
    } catch (error) {
      errorMessage = error.toString();
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
  }

  /*

  Stream<DocumentSnapshot> getByIdStream(String id) {
    return _ref.doc(id).snapshots(includeMetadataChanges: true);
  }

  Future<Client> getById(String id) async {
    DocumentSnapshot document = await _ref.doc(id).get();

    if (document.exists) {
      Client client = Client.fromJson(document.data());
      return client;
    }

    return null;
  }

  Future<void> update(Map<String, dynamic> data, String id) {
    return _ref.doc(id).update(data);
  }*/
}
