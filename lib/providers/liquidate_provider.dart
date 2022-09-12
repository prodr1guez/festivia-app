import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festivia/models/Artist.dart';

import '../models/Invoice.dart';

class LiquidateProvider {
  CollectionReference _ref;

  LiquidateProvider() {
    _ref = FirebaseFirestore.instance.collection('invoices');
  }

  Future<void> create(Invoice invoice) {
    String errorMessage;
    try {
      _ref.doc(invoice.id).set(invoice.toJson());
    } catch (error) {
      errorMessage = error.toString();
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
  }

  Future<List<Invoice>> getInvoices() async {
    QuerySnapshot querySnapshot = await _ref.get();

    List<Object> allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    List<Invoice> invoices = new List();

    for (Map<String, dynamic> data in allData) {
      invoices.add(Invoice.fromJson(data));
    }

    return invoices;
  }

  Future<Invoice> getInvoiceById(String id) async {
    DocumentSnapshot document = await _ref.doc(id).get();

    if (document.exists) {
      Invoice invoice = Invoice.fromJson(document.data());
      return invoice;
    }

    return null;
  }
}
