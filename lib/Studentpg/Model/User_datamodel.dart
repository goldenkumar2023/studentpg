// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

UserModel welcomeFromJson(String str) => UserModel.fromJson(json.decode(str));

String welcomeToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String name;
  String email;
  String phone;
  String address;
  String age;
  String gender;


  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.age,
    required this.gender

  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json["name"],
    email: json["email"],
    phone: json["pone"],
    address: json["address"],
    age: json["age"],
    gender: json["gender"],

  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "address": address,
    "address": age,
    "gender": gender

  };
}
