// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

GlobalData userFromJson(String str) => GlobalData.fromJson(json.decode(str));

String userToJson(GlobalData data) => json.encode(data.toJson());

class GlobalData {
  GlobalData({
    this.liquidateRevenue,
    this.ticketCommission,
  });

  double liquidateRevenue;
  double ticketCommission;

  factory GlobalData.fromJson(Map<String, dynamic> json) => GlobalData(
        liquidateRevenue: json["liquidateRevenue"] is int
            ? (json['liquidateRevenue'] as int).toDouble()
            : json['liquidateRevenue'],
        ticketCommission: json["ticketCommission"] is int
            ? (json['ticketCommission'] as int).toDouble()
            : json['ticketCommission'],
      );

  Map<String, dynamic> toJson() => {
        "liquidateRevenue": liquidateRevenue,
        "ticketCommission": ticketCommission,
      };
}
