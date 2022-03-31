import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festivia/models/Artist.dart';

class ArtistProvider {
  CollectionReference _ref;

  ArtistProvider() {
    _ref = FirebaseFirestore.instance.collection('Artists');
  }

  Future<List<Artist>> getArtists() async {
    QuerySnapshot querySnapshot = await _ref.get();

    List<Object> allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    List<Artist> artists = new List();

    for (Map<String, dynamic> data in allData) {
      artists.add(Artist.fromJson(data));
    }

    return artists;
  }
}
