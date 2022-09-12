// To parse this JSON data, do
//
//     final invoice = invoiceFromJson(jsonString);

import 'dart:convert';

Invoice invoiceFromJson(String str) => Invoice.fromJson(json.decode(str));

String invoiceToJson(Invoice data) => json.encode(data.toJson());

class Invoice {
  Invoice(
      {this.id,
      this.holderId,
      this.holder,
      this.cuil,
      this.amount,
      this.phone,
      this.cbu,
      this.date,
      this.state});

  String id;
  String holderId;
  String holder;
  String cuil;
  double amount;
  String phone;
  String cbu;
  String date;
  String state;

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
      id: json["id"],
      holderId: json["holderId"],
      holder: json["holder"],
      cuil: json["cuil"],
      amount: json["amount"],
      phone: json["phone"],
      cbu: json["cbu"],
      date: json["date"],
      state: json["state"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "holderId": holderId,
        "holder": holder,
        "cuil": cuil,
        "amount": amount,
        "phone": phone,
        "cbu": cbu,
        "date": date,
        "state": state
      };
}
