import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festivia/models/Like.dart';
import 'package:festivia/models/client.dart';

class ClientProvider {
  CollectionReference _ref;

  ClientProvider() {
    _ref = FirebaseFirestore.instance.collection('Clients');
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
  }

  Future<void> updateClientEvent(
      Map<String, dynamic> data, String id, String idEvent) {
    return _ref.doc(id).collection("events").doc(idEvent).set(data);
  }

  Future<bool> getLikeById(String idClient, String idArtist) async {
    DocumentSnapshot document =
        await _ref.doc(idClient).collection("likes").doc(idArtist).get();

    return document.exists;
  }

  Future<bool> getLikeNewById(String idClient, String idNews) async {
    DocumentSnapshot document =
        await _ref.doc(idClient).collection("likes").doc(idNews).get();

    return document.exists;
  }

  Future<void> addEvent(
      Map<String, dynamic> data, String idClient, String idEvent) {
    return _ref.doc(idClient).collection("events").doc(idEvent).set(data);
  }

  Future<void> addTicket(
      Map<String, dynamic> data, String idClient, String idEvent) {
    return _ref.doc(idClient).collection("tickets").doc(idEvent).set(data);
  }

  Future<void> addLikeArtist(String idClient, String idArtist) {
    return _ref
        .doc(idClient)
        .collection("likes")
        .doc(idArtist)
        .set({"idArtist": idArtist});
  }

  Future<void> addLikeNews(String idClient, String idNews) {
    return _ref
        .doc(idClient)
        .collection("likes")
        .doc(idNews)
        .set({"idNews": idNews});
  }

  Future<List<Like>> getLikes(String id) async {
    QuerySnapshot querySnapshot = await _ref.doc(id).collection("likes").get();

    List<Object> allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    List<Like> likes = new List();

    return likes;
  }

  Future<void> removeLikeArtist(String idClient, String idArtist) {
    return _ref.doc(idClient).collection("likes").doc(idArtist).delete();
  }

  Future<void> removeLikeNews(String idClient, String idNews) {
    return _ref.doc(idClient).collection("likes").doc(idNews).delete();
  }
}
