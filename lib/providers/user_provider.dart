import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festivia/models/User.dart';
import 'package:festivia/models/client.dart';

class UserProvider {
  CollectionReference _ref;

  UserProvider() {
    _ref = FirebaseFirestore.instance.collection('Users');
  }

  Future<void> create(User user) {
    String errorMessage;

    try {
      return _ref.doc(user.id).set(user.toJson());
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

  Future<User> getById(String id) async {
    DocumentSnapshot document = await _ref.doc(id).get();

    if (document.exists) {
      User user = User.fromJson(document.data());
      return user;
    }

    return null;
  }

  Future<void> update(Map<String, dynamic> data, String id) {
    return _ref.doc(id).update(data);
  }
}
