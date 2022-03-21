import 'dart:convert';

BannerMainHome bannerMainHomeFromJson(String str) =>
    BannerMainHome.fromJson(json.decode(str));

String bannerMainHomeToJson(BannerMainHome data) => json.encode(data.toJson());

class BannerMainHome {
  BannerMainHome({
    this.id,
    this.image,
    this.name,
    this.type,
  });

  String id;
  String image;
  String name;
  String type;

  factory BannerMainHome.fromJson(Map<String, dynamic> json) => BannerMainHome(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "type": type,
      };
}
