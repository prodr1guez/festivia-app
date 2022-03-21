// To parse this JSON data, do
//
//     final eventId = eventIdFromJson(jsonString);

import 'dart:convert';

EventId eventIdFromJson(String str) => EventId.fromJson(json.decode(str));

String eventIdToJson(EventId data) => json.encode(data.toJson());

class EventId {
  EventId({
    this.id,
  });

  String id;

  factory EventId.fromJson(Map<String, dynamic> json) => EventId(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
