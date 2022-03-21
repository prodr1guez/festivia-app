import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:festivia/models/HostEvent.dart';

class MyEventsProvider {
  CollectionReference _ref;

  MyEventsProvider() {
    _ref = FirebaseFirestore.instance.collection('Clients');
  }

  Future<List<HostEvent>> getMyEvents(String id) async {
    QuerySnapshot querySnapshot = await _ref.doc(id).collection("events").get();

    List<Object> allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    List<HostEvent> events = new List();

    for (Map<String, dynamic> data in allData) {
      events.add(HostEvent.fromJson(data));
    }

    return events;
  }
}
