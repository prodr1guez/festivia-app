import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festivia/models/Event.dart';
import 'package:festivia/providers/auth_provider.dart';
import 'package:festivia/providers/client_provider.dart';

class LikeProvider {
  CollectionReference _ref;
  CollectionReference _refNews;
  ClientProvider _clientProvider = ClientProvider();
  AuthProvider _authProvider = AuthProvider();

  LikeProvider() {
    _ref = FirebaseFirestore.instance.collection('Artists');
    _refNews = FirebaseFirestore.instance.collection('News');
  }

  Future<void> addLike(String idArtist) async {
    String errorMessage;

    try {
      await _clientProvider.addLikeArtist(
          idArtist, _authProvider.getUser().uid);
      await increaseLikeArtist(idArtist);
    } catch (error) {
      errorMessage = error.toString();
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
  }

  Future<void> addLikeNews(String idNews) async {
    String errorMessage;

    try {
      await _clientProvider.addLikeNews(idNews, _authProvider.getUser().uid);

      await increaseLikeArtist(idNews);
    } catch (error) {
      errorMessage = error.toString();
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
  }

  Future<void> removeLike(String idArtist) async {
    String errorMessage;

    try {
      await _clientProvider.removeLikeArtist(
          idArtist, _authProvider.getUser().uid);
      await decreaseLikeArtist(idArtist);
    } catch (error) {
      errorMessage = error.toString();
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
  }

  Future<void> decreaseLikeArtist(String id) {
    return _ref.doc(id).update({
      "likes": FieldValue.increment(-1),
    });
  }

  Future<void> decreaseLikeNews(String id) {
    return _refNews.doc(id).update({
      "likes": FieldValue.increment(-1),
    });
  }

  Future<void> increaseLikeArtist(String id) {
    return _ref.doc(id).update({
      "likes": FieldValue.increment(1),
    });
  }

  Future<void> increaseLikeNews(String id) {
    return _refNews.doc(id).update({
      "likes": FieldValue.increment(1),
    });
  }
}
