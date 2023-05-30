import 'dart:convert';

Client clientFromJson(String str) => Client.fromJson(json.decode(str));

String clientToJson(Client data) => json.encode(data.toJson());

class Client {
  String id;
  String username;
  String email;
  String phone;
  String location;
  double lat;
  double long;
  List<String> genders = List.empty();
  String image;

  Client(
      {this.id,
      this.username,
      this.email,
      this.phone,
      this.location,
      this.lat,
      this.long,
      this.genders,
      this.image});

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        location: json["location"],
        lat: json["lat"],
        long: json["long"],
        genders: List<String>.from(json["genders"].map((x) => x)),
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "phone": phone,
        "location": location,
        "lat": lat,
        "long": long,
        "genders": List<dynamic>.from(genders.map((x) => x)),
        "image": image,
      };
}
