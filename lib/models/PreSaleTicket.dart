import 'dart:convert';

PreSaleTicket preSaleTicketFromJson(String str) =>
    PreSaleTicket.fromJson(json.decode(str));

String preSaleTicketToJson(PreSaleTicket data) => json.encode(data.toJson());

class PreSaleTicket {
  PreSaleTicket(
      {this.id,
      this.tittle,
      this.price,
      this.numTickets,
      this.description,
      this.dateStart,
      this.dateEnd});

  String tittle;
  String price;
  int numTickets;
  String description;
  String dateStart;
  String dateStartParse;
  String dateEnd;
  String dateEndParse;
  String id;
  int index;

  factory PreSaleTicket.fromJson(Map<String, dynamic> json) => PreSaleTicket(
        id: json["id"],
        tittle: json["tittle"],
        price: json["price"],
        dateEnd: json["dateEnd"],
        dateStart: json["dateStart"],
        numTickets: json["numTickets"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tittle": tittle,
        "price": price,
        "dateEnd": dateEnd,
        "dateStart": dateStart,
        "numTickets": numTickets,
        "description": description,
      };
}
