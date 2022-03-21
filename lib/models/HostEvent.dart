// To parse this JSON data, do
//
//     final hostEvent = hostEventFromJson(jsonString);

import 'dart:convert';

HostEvent hostEventFromJson(String str) => HostEvent.fromJson(json.decode(str));

String hostEventToJson(HostEvent data) => json.encode(data.toJson());

class HostEvent {
  HostEvent({
    this.id,
    this.image,
    this.name,
  });

  String id;
  String image;
  String name;

  factory HostEvent.fromJson(Map<String, dynamic> json) => HostEvent(
        id: json["id"],
        image: json["image"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
      };
}
