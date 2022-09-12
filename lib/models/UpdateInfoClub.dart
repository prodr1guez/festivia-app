// To parse this JSON data, do
//
//     final club = clubFromJson(jsonString);

import 'dart:convert';

UpdateInfoClub clubFromJson(String str) =>
    UpdateInfoClub.fromJson(json.decode(str));

String clubToJson(UpdateInfoClub data) => json.encode(data.toJson());

class UpdateInfoClub {
  UpdateInfoClub({
    this.image,
    this.name,
    this.description,
    this.location,
    this.lat,
    this.long,
    this.phone,
    this.email,
  });

  String image;
  String name;
  String description;
  String location;
  double lat;
  double long;
  String phone;
  String email;

  factory UpdateInfoClub.fromJson(Map<String, dynamic> json) => UpdateInfoClub(
        image: json["image"],
        name: json["name"],
        description: json["description"],
        location: json["location"],
        lat: json["lat"],
        long: json["long"],
        phone: json["phone"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "description": description,
        "location": location,
        "lat": lat,
        "long": long,
        "phone": phone,
        "email": email,
      };
}
