// To parse this JSON data, do
//
//     final loginTokenModel = loginTokenModelFromMap(jsonString);

import 'dart:convert';

class LoginTokenModel {
  LoginTokenModel({
    required this.data,
  });

  final LoginData data;

  factory LoginTokenModel.fromJson(String str) =>
      LoginTokenModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginTokenModel.fromMap(Map<String, dynamic> json) => LoginTokenModel(
        data: LoginData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data.toMap(),
      };
}

class LoginData {
  LoginData({
    required this.token,
  });

  final String token;

  factory LoginData.fromJson(String str) => LoginData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginData.fromMap(Map<String, dynamic> json) => LoginData(
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "token": token,
      };
}
