import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festivia/models/Event.dart';
import 'package:festivia/models/HostEvent.dart';
import 'package:festivia/providers/auth_provider.dart';
import 'package:festivia/providers/client_provider.dart';
import 'package:min_id/min_id.dart';

class EventProvider {
  CollectionReference _ref;
  ClientProvider _clientProvider = new ClientProvider();
  AuthProvider _authProvider = new AuthProvider();

  EventProvider() {
    _ref = FirebaseFirestore.instance.collection('Events');
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
