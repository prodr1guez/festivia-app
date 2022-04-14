// To parse this JSON data, do
//
//     final artistImage = artistImageFromJson(jsonString);

import 'dart:convert';

ArtistImage artistImageFromJson(String str) =>
    ArtistImage.fromJson(json.decode(str));

String artistImageToJson(ArtistImage data) => json.encode(data.toJson());

class ArtistImage {
  ArtistImage({
    this.name,
    this.url,
  });

  String name;
  String url;

  factory ArtistImage.fromJson(Map<String, dynamic> json) => ArtistImage(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
