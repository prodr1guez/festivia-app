import 'package:flutter/material.dart';

class PreSaleTickets {
  TextEditingController tittle;
  TextEditingController price;
  TextEditingController numTickets;
  TextEditingController description;
  String dateStart;
  String dateStartParse;
  String dateEnd;
  String dateEndParsed;
  int index;

  PreSaleTickets(this.tittle, this.price, this.numTickets, this.description);
}
