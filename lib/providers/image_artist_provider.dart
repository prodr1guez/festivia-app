import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festivia/models/ArtistImage.dart';

class ImageArtistProvider {
  CollectionReference _ref;

  ImageArtistProvider() {
    _ref = FirebaseFirestore.instance.collection('ArtistsImage');
  }

  Future<void> create(ArtistImage artistImage) {
    String errorMessage;

    try {
      _ref.doc(artistImage.name).set(artistImage.toJson());
    } catch (error) {
      errorMessage = error.toString();
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
  }
}
