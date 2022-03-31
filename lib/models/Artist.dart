// To parse this JSON data, do
//
//     final artist = artistFromJson(jsonString);

import 'dart:convert';

Artist artistFromJson(String str) => Artist.fromJson(json.decode(str));

String artistToJson(Artist data) => json.encode(data.toJson());

class Artist {
  Artist({
    this.id,
    this.name,
    this.instagram,
    this.facebook,
    this.soundcloud,
    this.youtube,
    this.likes,
    this.bio,
    this.genres,
    this.image,
  });

  String id;
  String name;
  String instagram;
  String facebook;
  String soundcloud;
  String youtube;
  int likes;
  String bio;
  List<String> genres;
  String image;

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        id: json["id"],
        name: json["name"],
        instagram: json["instagram"],
        facebook: json["facebook"],
        soundcloud: json["soundcloud"],
        youtube: json["youtube"],
        likes: json["likes"],
        bio: json["bio"],
        genres: List<String>.from(json["genres"].map((x) => x)),
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "instagram": instagram,
        "facebook": facebook,
        "soundcloud": soundcloud,
        "youtube": youtube,
        "likes": likes,
        "bio": bio,
        "genres": List<dynamic>.from(genres.map((x) => x)),
        "image": image,
      };
}
