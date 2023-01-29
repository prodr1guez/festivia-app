// To parse this JSON data, do
//
//     final club = clubFromJson(jsonString);

import 'dart:convert';

Club clubFromJson(String str) => Club.fromJson(json.decode(str));

String clubToJson(Club data) => json.encode(data.toJson());

class Club {
  Club(
      {this.id,
      this.image,
      this.name,
      this.description,
      this.location,
      this.lat,
      this.long,
      this.phone,
      this.email,
      this.revenueYear,
      this.ticketsYear,
      this.ticketsNextEvents,
      this.nextEvents,
      this.currentRevenue,
      this.promoted});

  String id;
  String image;
  String name;
  String description;
  String location = "";
  double lat;
  double long;
  String phone;
  String email;
  double revenueYear;
  int ticketsYear;
  int ticketsNextEvents;
  int nextEvents;
  double currentRevenue;
  bool promoted;

  factory Club.fromJson(Map<String, dynamic> json) => Club(
      id: json["id"],
      image: json["image"],
      name: json["name"],
      description: json["description"],
      location: json["location"],
      lat: json["lat"],
      long: json["long"],
      phone: json["phone"],
      email: json["email"],
      revenueYear: json["revenueYear"] is int
          ? (json['revenueYear'] as int).toDouble()
          : json['revenueYear'],
      ticketsYear: json["ticketsYear"],
      ticketsNextEvents: json["ticketsNextEvents"],
      nextEvents: json["nextEvents"],
      currentRevenue: json["currentRevenue"] is int
          ? (json['currentRevenue'] as int).toDouble()
          : json['currentRevenue'],
      promoted: json["promoted"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "description": description,
        "location": location,
        "lat": lat,
        "long": long,
        "phone": phone,
        "email": email,
        "revenueYear": revenueYear,
        "ticketsYear": ticketsYear,
        "ticketsNextEvents": ticketsNextEvents,
        "nextEvents": nextEvents,
        "currentRevenue": currentRevenue,
        "promoted": promoted
      };
}
