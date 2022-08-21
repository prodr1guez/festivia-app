import 'dart:convert';

Event eventFromJson(String str) => Event.fromJson(json.decode(str));

String eventToJson(Event data) => json.encode(data.toJson());

class Event {
  Event(
      {this.id,
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
      this.maxTicketsFreePass,
      this.isPaidOff,
      this.price,
      this.maxTicketsPaidOffEvent,
      this.idHost,
      this.location,
      this.descriptionTicketFree,
      this.descriptionTicketGeneral,
      this.assistants,
      this.revenue,
      this.generalTicketsSold,
      this.freeTicketsSold,
      this.vipTicketsSold,
      this.typeHost});

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
  int maxTicketsFreePass;
  bool isPaidOff;
  String price;
  int maxTicketsPaidOffEvent;
  String idHost;
  String location;
  String descriptionTicketFree;
  String descriptionTicketGeneral;
  int assistants;
  double revenue;
  int generalTicketsSold;
  int freeTicketsSold;
  int vipTicketsSold;
  String typeHost;

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
      maxTicketsFreePass: json["maxTicketsFreePass"],
      isPaidOff: json["isPaidOff"],
      price: json["price"],
      maxTicketsPaidOffEvent: json["maxTicketsPaidOffEvent"],
      idHost: json["idHost"],
      location: json["location"],
      descriptionTicketFree: json["descriptionTicketFree"],
      descriptionTicketGeneral: json["descriptionTicketGeneral"],
      assistants: json["assistants"],
      revenue: json["revenue"] is int
          ? (json['revenue'] as int).toDouble()
          : json['revenue'],
      generalTicketsSold: json["generalTicketsSold"],
      freeTicketsSold: json["freeTicketsSold"],
      vipTicketsSold: json["vipTicketsSold"],
      typeHost: json["typeHost"]);

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
        "maxTicketsFreePass": maxTicketsFreePass,
        "isPaidOff": isPaidOff,
        "price": price,
        "maxTicketsPaidOffEvent": maxTicketsPaidOffEvent,
        "idHost": idHost,
        "location": location,
        "descriptionTicketFree": descriptionTicketFree,
        "descriptionTicketGeneral": descriptionTicketGeneral,
        "assistants": assistants,
        "revenue": revenue,
        "generalTicketsSold": generalTicketsSold,
        "freeTicketsSold": freeTicketsSold,
        "vipTicketsSold": vipTicketsSold,
        "typeHost": typeHost
      };
}
