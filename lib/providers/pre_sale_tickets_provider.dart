import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festivia/models/Event.dart';
import 'package:festivia/models/PreSaleTicket.dart';
import 'package:festivia/models/Ticket.dart';
import 'package:festivia/providers/auth_provider.dart';
import 'package:festivia/providers/client_provider.dart';
import 'package:festivia/providers/club_provider.dart';
import 'package:festivia/providers/event_provider.dart';
import 'package:min_id/min_id.dart';

class PreSaleTicketsProvider {
  CollectionReference _ref;

  EventProvider _eventProvider = new EventProvider();

  Future<void> addPreSaleTickets(
      List<PreSaleTicket> tickets, String idEvent) async {
    String errorMessage;

    try {
      await _eventProvider.addPreSaleTickets(tickets, idEvent);
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
}
