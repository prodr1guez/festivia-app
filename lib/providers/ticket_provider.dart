import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festivia/models/Event.dart';
import 'package:festivia/models/HostEvent.dart';
import 'package:festivia/models/Ticket.dart';
import 'package:festivia/providers/auth_provider.dart';
import 'package:festivia/providers/client_provider.dart';
import 'package:festivia/providers/event_provider.dart';
import 'package:min_id/min_id.dart';

class TicketProvider {
  CollectionReference _ref;
  ClientProvider _clientProvider = new ClientProvider();
  AuthProvider _authProvider = new AuthProvider();
  EventProvider _eventProvider = new EventProvider();

  Future<void> create(Ticket ticket, String idEvent) async {
    String errorMessage;

    print("TEST 1     " + _authProvider.getUser().uid);
    print("TEST IDEVENT    " + idEvent);

    print(ticket.toJson().toString());
    try {
      await _clientProvider.addTicket(
          ticket.toJson(), _authProvider.getUser().uid, ticket.ticketId);

      await _eventProvider.addTicketInEvent(ticket, idEvent);
    } catch (error) {
      errorMessage = error.toString();
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
  }

  Future<Event> getById(String id) async {
    DocumentSnapshot document = await _ref.doc(id).get();

    if (document.exists) {
      Event event = Event.fromJson(document.data());
      return event;
    }

    return null;
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
