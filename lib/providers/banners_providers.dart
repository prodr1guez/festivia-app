import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festivia/models/BannerMainHome.dart';
import 'package:festivia/models/SuggestClub.dart';
import 'package:festivia/models/SuggestParty.dart';
import 'package:festivia/models/client.dart';

class BannersProvider {
  CollectionReference _ref;
  CollectionReference _refParties;
  CollectionReference _refClubs;

  BannersProvider() {
    _ref = FirebaseFirestore.instance.collection('MainBanner');
    _refParties = FirebaseFirestore.instance.collection('SuggestsParties');
    _refClubs = FirebaseFirestore.instance.collection('SuggestsClubs');
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

  Future<List<SuggestParty>> getSuggestPartiesData() async {
    QuerySnapshot querySnapshot = await _refParties.get();

    List<Object> allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    List<SuggestParty> dataBanners = new List();

    for (Map<String, dynamic> data in allData) {
      dataBanners.add(SuggestParty.fromJson(data));
    }

    return dataBanners;
  }

  Future<List<SuggestClub>> getSuggestClubsData() async {
    QuerySnapshot querySnapshot = await _refClubs.get();

    List<Object> allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    List<SuggestClub> dataBanners = new List();

    for (Map<String, dynamic> data in allData) {
      dataBanners.add(SuggestClub.fromJson(data));
    }

    return dataBanners;
  }
}
