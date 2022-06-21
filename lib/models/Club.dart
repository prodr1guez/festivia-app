// To parse this JSON data, do
//
//     final club = clubFromJson(jsonString);

import 'dart:convert';

import 'dart:ffi';

Club clubFromJson(String str) => Club.fromJson(json.decode(str));

String clubToJson(Club data) => json.encode(data.toJson());

class Club {
  Club({
    this.id,
    this.image,
    this.name,
    this.description,
    this.location,
    this.lat,
    this.long,
  });

  String id;
  String image;
  String name;
  String description;
  String location;
  double lat;
  double long;

  factory Club.fromJson(Map<String, dynamic> json) => Club(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        description: json["description"],
        location: json["location"],
        lat: json["lat"],
        long: json["long"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "description": description,
        "location": location,
        "lat": lat,
        "long": long,
      };
}
