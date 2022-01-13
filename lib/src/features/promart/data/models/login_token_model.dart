// To parse this JSON data, do
//
//     final loginTokenModel = loginTokenModelFromMap(jsonString);

// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:convert';

import 'package:equatable/equatable.dart';

class LoginTokenModel extends Equatable {
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

  @override
  List<Object?> get props => [data];
}

class LoginData extends Equatable {
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

  @override
  List<Object?> get props => [token];
}
