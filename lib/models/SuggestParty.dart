// To parse this JSON data, do
//
//     final suggestParty = suggestPartyFromJson(jsonString);

import 'dart:convert';

SuggestParty suggestPartyFromJson(String str) =>
    SuggestParty.fromJson(json.decode(str));

String suggestPartyToJson(SuggestParty data) => json.encode(data.toJson());

class SuggestParty {
  SuggestParty(
      {this.id, this.image, this.name, this.type, this.location, this.date});

  String id;
  String image;
  String name;
  String type;
  String location;
  String date;

  factory SuggestParty.fromJson(Map<String, dynamic> json) => SuggestParty(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        type: json["type"],
        location: json["location"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "type": type,
        "location": location,
        "date": date,
      };
}
