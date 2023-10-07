// To parse this JSON data, do
//
//     final pgModels = pgModelsFromJson(jsonString);

import 'dart:convert';

PgModels pgModelsFromJson(String str) => PgModels.fromJson(json.decode(str));

String pgModelsToJson(PgModels data) => json.encode(data.toJson());

class PgModels {
  String name;
  String address;
  String price;
  List<String> images;

  PgModels({
    required this.name,
    required this.address,
    required this.price,
    required this.images,
  });

  factory PgModels.fromJson(Map<String, dynamic> json) => PgModels(
    name: json["name"],
    address: json["address"],
    price: json["price"],
    images: List<String>.from(json["images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "address": address,
    "price": price,
    "images": List<dynamic>.from(images.map((x) => x)),
  };
}
