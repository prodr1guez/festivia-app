import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festivia/models/GlobalData.dart';
import 'package:festivia/models/User.dart';
import 'package:festivia/models/client.dart';

class GlobalDataProvider {
  CollectionReference _ref;

  GlobalDataProvider() {
    _ref = FirebaseFirestore.instance.collection('globalData');
  }

  Stream<DocumentSnapshot> getByIdStream(String id) {
    return _ref.doc(id).snapshots(includeMetadataChanges: true);
  }

  Future<GlobalData> getDataCommissions() async {
    DocumentSnapshot document = await _ref.doc("commissions").get();

    if (document.exists) {
      GlobalData globalData = GlobalData.fromJson(document.data());
      return globalData;
    }

    return null;
  }

  Future<void> update(Map<String, dynamic> data, String id) {
    return _ref.doc(id).update(data);
  }
}
