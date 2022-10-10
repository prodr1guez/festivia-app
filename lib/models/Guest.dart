// To parse this JSON data, do
//
//     final guest = guestFromJson(jsonString);

import 'dart:convert';

Guest guestFromJson(String str) => Guest.fromJson(json.decode(str));

String guestToJson(Guest data) => json.encode(data.toJson());

class Guest {
  Guest({
    this.id,
    this.name,
    this.code,
    this.type,
  });

  String id;
  String name;
  String code;
  String type;

  factory Guest.fromJson(Map<String, dynamic> json) => Guest(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "type": type,
      };
}
