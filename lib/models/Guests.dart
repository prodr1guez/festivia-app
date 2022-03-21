// To parse this JSON data, do
//
//     final guests = guestsFromJson(jsonString);

import 'dart:convert';

Guests guestsFromJson(String str) => Guests.fromJson(json.decode(str));

String guestsToJson(Guests data) => json.encode(data.toJson());

class Guests {
  Guests({
    this.name,
    this.code,
    this.dni,
    this.type,
  });

  String name;
  String code;
  String dni;
  String type;

  factory Guests.fromJson(Map<String, dynamic> json) => Guests(
        name: json["name"],
        code: json["code"],
        dni: json["dni"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "dni": dni,
        "type": type,
      };
}
