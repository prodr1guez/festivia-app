// To parse this JSON data, do
//
//     final ticket = ticketFromJson(jsonString);

import 'dart:convert';

Ticket ticketFromJson(String str) => Ticket.fromJson(json.decode(str));

String ticketToJson(Ticket data) => json.encode(data.toJson());

class Ticket {
  Ticket({
    this.ticketId,
    this.payId,
    this.name,
    this.type,
  });

  String ticketId;
  String payId;
  String name;
  String type;

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        ticketId: json["TicketID"],
        payId: json["PayId"],
        name: json["name"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "TicketID": ticketId,
        "PayId": payId,
        "name": name,
        "type": type,
      };
}
