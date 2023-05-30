// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString);

import 'dart:convert';

News newsFromJson(String str) => News.fromJson(json.decode(str));

String newsToJson(News data) => json.encode(data.toJson());

class News {
  String id;
  String tittle;
  String image;
  String date;
  String content;
  int likes;

  News({
    this.id,
    this.tittle,
    this.image,
    this.date,
    this.content,
    this.likes,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
        id: json["id"],
        tittle: json["tittle"],
        image: json["image"],
        date: json["date"],
        content: json["content"],
        likes: json["likes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tittle": tittle,
        "image": image,
        "date": date,
        "content": content,
        "likes": likes,
      };
}
