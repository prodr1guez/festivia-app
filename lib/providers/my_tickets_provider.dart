import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:festivia/models/HostEvent.dart';

import '../models/Ticket.dart';

class MyTicketsProvider {
  CollectionReference _ref;

  MyTicketsProvider() {
    _ref = FirebaseFirestore.instance.collection('Clients');
  }

  Future<List<Ticket>> getMyTickets(String id) async {
    print("paso 2");
    QuerySnapshot querySnapshot =
        await _ref.doc(id).collection("tickets").get();

    List<Object> allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    List<Ticket> tickets = new List();

    for (Map<String, dynamic> data in allData) {
      tickets.add(Ticket.fromJson(data));
    }

    return tickets;
  }
}
