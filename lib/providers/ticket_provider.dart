import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festivia/models/Event.dart';
import 'package:festivia/models/Ticket.dart';
import 'package:festivia/providers/auth_provider.dart';
import 'package:festivia/providers/client_provider.dart';
import 'package:festivia/providers/club_provider.dart';
import 'package:festivia/providers/event_provider.dart';
import 'package:min_id/min_id.dart';

import '../models/PreSaleTicket.dart';

class TicketProvider {
  CollectionReference _ref;
  ClientProvider _clientProvider = new ClientProvider();
  AuthProvider _authProvider = new AuthProvider();
  EventProvider _eventProvider = new EventProvider();
  ClubProvider _clubProvider = new ClubProvider();

  Future<void> create(Ticket ticket, String idEvent, double revenue,
      String typeHost, String idClub, String preSaleTicketId) async {
    String errorMessage;

    try {
      await _clientProvider.addTicket(
          ticket.toJson(), _authProvider.getUser().uid, ticket.ticketId);

      await _eventProvider.addTicketInEvent(ticket, idEvent);

      if (ticket.type == "free") {
        await _eventProvider.decreaseTicketFree(idEvent);
        await _eventProvider.increaseTicketFreeSold(idEvent);
        await _eventProvider.increaseAssistants(idEvent);
      } else if (ticket.type == "preSale") {
        await _eventProvider.decreasePreSaleTicket(idEvent, preSaleTicketId);
        await _eventProvider.increaseTicketSold(idEvent);
        await _eventProvider.increaseAssistants(idEvent);
        await _eventProvider.increaseRevenue(idEvent, revenue);

        if (typeHost == "club") {
          await _clubProvider.increaseRevenue(idClub, revenue);
        }
      } else {
        await _eventProvider.decreaseTicketGeneral(idEvent);
        await _eventProvider.increaseTicketSold(idEvent);
        await _eventProvider.increaseAssistants(idEvent);
        await _eventProvider.increaseRevenue(idEvent, revenue);

        if (typeHost == "club") {
          await _clubProvider.increaseRevenue(idClub, revenue);
        }
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
}
