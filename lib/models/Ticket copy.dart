// To parse this JSON data, do
//
//     final ticket = ticketFromJson(jsonString);

import 'dart:convert';

Ticket ticketFromJson(String str) => Ticket.fromJson(json.decode(str));

String ticketToJson(Ticket data) => json.encode(data.toJson());

class Ticket {
  Ticket(
      {this.ticketId,
      this.payId,
      this.name,
      this.type,
      this.date,
      this.nameEvent,
      this.location,
      this.image,
      this.checkedIn});

  String ticketId;
  String payId;
  String name;
  String type;
  String date;
  String nameEvent;
  String location;
  String image;
  bool checkedIn;

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
      ticketId: json["ticketId"],
      payId: json["payId"],
      name: json["name"],
      type: json["type"],
      date: json["date"],
      nameEvent: json["nameEvent"],
      location: json["location"],
      image: json["image"],
      checkedIn: json["checkedIn"]);

  Map<String, dynamic> toJson() => {
        "ticketId": ticketId,
        "payId": payId,
        "name": name,
        "type": type,
        "date": date,
        "nameEvent": nameEvent,
        "location": location,
        "image": image,
        "checkedIn": checkedIn
      };

  static Map<String, dynamic> toMap(Ticket ticket) => {
        "ticketId": ticket.ticketId,
        "payId": ticket.payId,
        "name": ticket.name,
        "type": ticket.type,
        "date": ticket.date,
        "nameEvent": ticket.nameEvent,
        "location": ticket.location,
        "image": ticket.image,
        "checkedIn": ticket.checkedIn
      };

  static String encode(List<Ticket> tickets) => json.encode(
        tickets
            .map<Map<String, dynamic>>((ticket) => Ticket.toMap(ticket))
            .toList(),
      );

  static List<Ticket> decode(String tickets) =>
      (json.decode(tickets) as List<dynamic>)
          .map<Ticket>((item) => Ticket.fromJson(item))
          .toList();
}
