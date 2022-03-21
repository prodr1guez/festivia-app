// To parse this JSON data, do
//
//     final suggestClub = suggestClubFromJson(jsonString);

import 'dart:convert';

SuggestClub suggestClubFromJson(String str) => SuggestClub.fromJson(json.decode(str));

String suggestClubToJson(SuggestClub data) => json.encode(data.toJson());

class SuggestClub {
    SuggestClub({
        this.id,
        this.image,
        this.name,
        this.type,
        this.location,
    });

    String id;
    String image;
    String name;
    String type;
    String location;

    factory SuggestClub.fromJson(Map<String, dynamic> json) => SuggestClub(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        type: json["type"],
        location: json["location"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "type": type,
        "location": location,
    };
}
