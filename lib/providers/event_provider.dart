import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festivia/models/Event.dart';
import 'package:festivia/models/HostEvent.dart';
import 'package:festivia/models/Ticket.dart';
import 'package:festivia/models/User.dart';
import 'package:festivia/providers/auth_provider.dart';
import 'package:festivia/providers/client_provider.dart';
import 'package:festivia/providers/club_provider.dart';
import 'package:festivia/providers/user_provider.dart';
import 'package:festivia/utils/DateParsed.dart';
import 'package:min_id/min_id.dart';

class EventProvider {
  CollectionReference _ref;
  ClientProvider _clientProvider = new ClientProvider();
  ClubProvider _clubProvider = new ClubProvider();
  AuthProvider _authProvider = new AuthProvider();
  UserProvider _userProvider = new UserProvider();

  EventProvider() {
    _ref = FirebaseFirestore.instance.collection('Events');
  }

  Future<List<Event>> getEvents() async {
    QuerySnapshot querySnapshot = await _ref.get();

    List<Object> allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    List<Event> artists = new List();

    for (Map<String, dynamic> data in allData) {
      if (DateParse().CompareDateBool(Event.fromJson(data).dateEnd)) {
        artists.add(Event.fromJson(data));
      }
    }

    return artists;
  }

  Future<void> create(Event event) async {
    String errorMessage;

    try {
      _ref.doc(event.id).set(event.toJson());

      HostEvent eventHost =
          HostEvent(id: event.id, image: event.image, name: event.tittle);

      User user = await _userProvider.getById(_authProvider.getUser().uid);

      if (user.type.contains("club")) {
        _clubProvider.addEvent(
            eventHost.toJson(), _authProvider.getUser().uid, event.id);
      } else {
        _clientProvider.addEvent(
            eventHost.toJson(), _authProvider.getUser().uid, event.id);
      }
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

  Future<void> decreaseTicketFree(String id) {
    return _ref.doc(id).update({
      "maxTicketsFreePass": FieldValue.increment(-1),
    });
  }

  Future<void> increaseTicketFreeSold(String id) {
    return _ref.doc(id).update({
      "freeTicketsSold": FieldValue.increment(1),
    });
  }

  Future<void> increaseAssistants(String id) {
    return _ref.doc(id).update({
      "assistants": FieldValue.increment(1),
    });
  }

  Future<void> increaseTicketGeneralSold(String id) {
    return _ref.doc(id).update({
      "generalTicketsSold": FieldValue.increment(1),
    });
  }

  Future<void> decreaseTicketGeneral(String id) {
    return _ref.doc(id).update({
      "maxTicketsPaidOffEvent": FieldValue.increment(-1),
    });
  }

  Future<void> increaseRevenue(String id, double revenue) {
    return _ref.doc(id).update({
      "revenue": FieldValue.increment(revenue),
    });
  }

  Future<void> update(Map<String, dynamic> data, String id) {
    return _ref.doc(id).update(data);
  }
}
