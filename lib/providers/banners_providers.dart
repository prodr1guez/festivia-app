import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festivia/models/BannerMainHome.dart';
import 'package:festivia/models/Event.dart';
import 'package:festivia/models/SuggestClub.dart';
import 'package:festivia/models/SuggestParty.dart';
import 'package:festivia/models/client.dart';

import '../models/Club.dart';

class BannersProvider {
  CollectionReference _ref;
  CollectionReference _refParties;
  CollectionReference _refClubs;

  BannersProvider() {
    _ref = FirebaseFirestore.instance.collection('MainBanner');
    _refParties = FirebaseFirestore.instance.collection('Events');
    _refClubs = FirebaseFirestore.instance.collection('Clubs');
  }

  Future<void> create(Client client) {
    String errorMessage;

    try {
      return _ref.doc(client.id).set(client.toJson());
    } catch (error) {
      errorMessage = error.code;
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
  }

  Stream<DocumentSnapshot> getByIdStream(String id) {
    return _ref.doc(id).snapshots(includeMetadataChanges: true);
  }

  Future<BannerMainHome> getById(String id) async {
    DocumentSnapshot document = await _ref.doc(id).get();

    if (document.exists) {
      BannerMainHome banner = BannerMainHome.fromJson(document.data());
      return banner;
    }

    return null;
  }

  Future<void> update(Map<String, dynamic> data, String id) {
    return _ref.doc(id).update(data);
  }

  Future<List<BannerMainHome>> getBannersData() async {
    QuerySnapshot querySnapshot = await _ref.get();

    List<Object> allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    List<BannerMainHome> dataBanners = new List();

    for (Map<String, dynamic> data in allData) {
      dataBanners.add(BannerMainHome.fromJson(data));
    }

    return dataBanners;
  }

  Future<List<Event>> getSuggestPartiesData() async {
    QuerySnapshot querySnapshot = await _refParties.get();

    List<Object> allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    List<Event> dataBanners = new List();
    for (Map<String, dynamic> data in allData) {
      Event event = Event.fromJson(data);
      if (event.promoted) {
        dataBanners.add(event);
      }
    }

    return dataBanners;
  }

  Future<List<Club>> getSuggestClubsData() async {
    QuerySnapshot querySnapshot = await _refClubs.get();
    List<Object> allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    List<Club> dataBanners = new List();
    for (Map<String, dynamic> data in allData) {
      Club club = Club.fromJson(data);
      if (club.promoted) {
        dataBanners.add(club);
      }
    }

    return dataBanners;
  }
}
