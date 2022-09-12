// To parse this JSON data, do
//
//     final hostEvent = hostEventFromJson(jsonString);

import 'dart:convert';

HostEvent hostEventFromJson(String str) => HostEvent.fromJson(json.decode(str));

String hostEventToJson(HostEvent data) => json.encode(data.toJson());

class HostEvent {
  HostEvent({this.id, this.image, this.name, this.location, this.dateEnd});

  String id;
  String image;
  String name;
  String location;
  String dateEnd;

  factory HostEvent.fromJson(Map<String, dynamic> json) => HostEvent(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        location: json["location"],
        dateEnd: json["dateEnd"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "location": location,
        "dateEnd": dateEnd,
      };
}
