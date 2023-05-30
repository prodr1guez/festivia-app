import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:festivia/providers/client_provider.dart';

import '../models/News.dart';

class NewProvider {
  CollectionReference _ref;
  ClientProvider _clientProvider = new ClientProvider();

  NewProvider() {
    _ref = FirebaseFirestore.instance.collection('News');
  }

  Future<List<News>> getNews() async {
    QuerySnapshot querySnapshot = await _ref.get();

    List<Object> allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    List<News> news = new List();

    for (Map<String, dynamic> data in allData) {
      news.add(News.fromJson(data));
    }

    return news;
  }

  Future<void> increaselike(String id) {
    return _ref.doc(id).update({
      "likes": FieldValue.increment(-1),
    });
  }

  Future<void> update(Map<String, dynamic> data, String id) async {
    return await _ref.doc(id).update(data);
  }
}
