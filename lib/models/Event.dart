// To parse this JSON data, do
//
//     final event = eventFromJson(jsonString);

import 'dart:convert';

Event eventFromJson(String str) => Event.fromJson(json.decode(str));

String eventToJson(Event data) => json.encode(data.toJson());

class Event {
  Event({
    this.id,
    this.image,
    this.tittle,
    this.dateStart,
    this.dateStartParsed,
    this.dateEnd,
    this.dateEndParsed,
    this.description,
    this.genders,
    this.ageMin,
    this.isFree,
    this.isTimeLimit,
    this.dateEndFreePass,
    this.dateEndFreePassParsed,
    this.maxFreeTicketsOrder,
    this.maxTicketsFreePass,
    this.isPaidOff,
    this.price,
    this.maxTicketsPaidOff,
    this.maxTicketsPaidOffEvent,
    this.idHost,
  });

  String id;
  String image;
  String tittle;
  String dateStart;
  String dateStartParsed;
  String dateEnd;
  String dateEndParsed;
  String description;
  List<String> genders;
  String ageMin;
  bool isFree;
  bool isTimeLimit;
  String dateEndFreePass;
  String dateEndFreePassParsed;
  String maxFreeTicketsOrder;
  String maxTicketsFreePass;
  bool isPaidOff;
  String price;
  String maxTicketsPaidOff;
  String maxTicketsPaidOffEvent;
  String idHost;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        image: json["image"],
        tittle: json["tittle"],
        dateStart: json["dateStart"],
        dateStartParsed: json["dateStartParsed"],
        dateEnd: json["dateEnd"],
        dateEndParsed: json["dateEndParsed"],
        description: json["description"],
        genders: List<String>.from(json["genders"].map((x) => x)),
        ageMin: json["ageMin"],
        isFree: json["isFree"],
        isTimeLimit: json["isTimeLimit"],
        dateEndFreePass: json["dateEndFreePass"],
        dateEndFreePassParsed: json["dateEndFreePassParsed"],
        maxFreeTicketsOrder: json["maxFreeTicketsOrder"],
        maxTicketsFreePass: json["maxTicketsFreePass"],
        isPaidOff: json["isPaidOff"],
        price: json["price"],
        maxTicketsPaidOff: json["maxTicketsPaidOff"],
        maxTicketsPaidOffEvent: json["maxTicketsPaidOffEvent"],
        idHost: json["idHost"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "tittle": tittle,
        "dateStart": dateStart,
        "dateStartParsed": dateStartParsed,
        "dateEnd": dateEnd,
        "dateEndParsed": dateEndParsed,
        "description": description,
        "genders": List<dynamic>.from(genders.map((x) => x)),
        "ageMin": ageMin,
        "isFree": isFree,
        "isTimeLimit": isTimeLimit,
        "dateEndFreePass": dateEndFreePass,
        "dateEndFreePassParsed": dateEndFreePassParsed,
        "maxFreeTicketsOrder": maxFreeTicketsOrder,
        "maxTicketsFreePass": maxTicketsFreePass,
        "isPaidOff": isPaidOff,
        "price": price,
        "maxTicketsPaidOff": maxTicketsPaidOff,
        "maxTicketsPaidOffEvent": maxTicketsPaidOffEvent,
        "idHost": idHost,
      };
}
