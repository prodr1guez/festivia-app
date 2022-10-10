import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festivia/models/Event.dart';
import 'package:festivia/models/HostEvent.dart';
import 'package:festivia/models/Ticket.dart';
import 'package:festivia/providers/auth_provider.dart';
import 'package:festivia/providers/client_provider.dart';
import 'package:festivia/utils/DateParsed.dart';
import 'package:min_id/min_id.dart';

import '../models/Club.dart';

class ClubProvider {
  CollectionReference _ref;
  ClientProvider _clientProvider = new ClientProvider();
  AuthProvider _authProvider = new AuthProvider();

  ClubProvider() {
    _ref = FirebaseFirestore.instance.collection('Clubs');
  }

  Future<List<Club>> getClubs() async {
    QuerySnapshot querySnapshot = await _ref.get();

    List<Object> allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    List<Club> clubs = new List();

    for (Map<String, dynamic> data in allData) {
      clubs.add(Club.fromJson(data));
    }

    clubs.shuffle();
    return clubs;
  }

  Future<void> create(Club club) {
    String errorMessage;

    try {
      _ref.doc(club.id).set(club.toJson());
    } catch (error) {
      errorMessage = error.toString();
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
  }

  Future<void> increaseAssistans(String id) {
    return _ref.doc(id).update({
      "assistantsNextEvents": FieldValue.increment(1),
    });
  }

  Future<void> liquidateRevenue(String id, double amount) {
    return _ref.doc(id).update({
      "currentRevenue": FieldValue.increment(-amount),
    });
  }

  Future<void> increaseRevenue(String id, double revenue) {
    return _ref.doc(id).update({
      "revenueYear": FieldValue.increment(revenue),
      "ticketsYear": FieldValue.increment(1),
      "currentRevenue": FieldValue.increment(revenue),
      "ticketsNextEvents": FieldValue.increment(1),
    });
  }

  Future<void> addEvent(
      Map<String, dynamic> data, String idClub, String idEvent) {
    return _ref.doc(idClub).collection("events").doc(idEvent).set(data);
  }

  Future<Club> getById(String id) async {
    DocumentSnapshot document = await _ref.doc(id).get();

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

  Future<List<HostEvent>> EventsClub(String id) async {
    QuerySnapshot querySnapshot = await _ref.doc(id).collection("events").get();

    List<Object> allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    List<HostEvent> events = new List();

    for (Map<String, dynamic> data in allData) {
      events.add(HostEvent.fromJson(data));
    }

    return events;
  }

  Future<List<HostEvent>> getNextEventsClub(String id) async {
    QuerySnapshot querySnapshot = await _ref.doc(id).collection("events").get();

    List<Object> allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    List<HostEvent> events = new List();

    for (Map<String, dynamic> data in allData) {
      if (DateParse().CompareDateBool(HostEvent.fromJson(data).dateEnd)) {
        events.add(HostEvent.fromJson(data));
      }
    }

    return events;
  }

  Future<List<HostEvent>> EventsForClub(String id) async {
    QuerySnapshot querySnapshot = await _ref.doc(id).collection("events").get();

    List<Object> allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    List<HostEvent> events = new List();

    for (Map<String, dynamic> data in allData) {
      if (DateParse().CompareDateBool(HostEvent.fromJson(data).dateEnd)) {
        events.add(HostEvent.fromJson(data));
      }
    }

    return events;
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
  */
  Future<void> update(Map<String, dynamic> data, String id) async {
    return await _ref.doc(id).update(data);
  }
}
