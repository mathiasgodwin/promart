// To parse this JSON data, do
//
//     final allUserModel = allUserModelFromMap(jsonString);

// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:convert';

import 'package:equatable/equatable.dart';

class AllUserModel extends Equatable {
  AllUserModel({
    required this.data,
  });

  final List<AllUserData> data;

  factory AllUserModel.fromJson(String str) =>
      AllUserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllUserModel.fromMap(Map<String, dynamic> json) => AllUserModel(
        data: List<AllUserData>.from(
            json["data"].map((x) => AllUserData.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };

  @override
  List<Object?> get props => [data];
}

class AllUserData extends Equatable {
  AllUserData({
    required this.address,
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.phone,
    required this.v,
  });

  final AllUserAddress address;
  final int id;
  final String email;
  final String username;
  final String password;
  final AllUserName name;
  final String phone;
  final int v;

  factory AllUserData.fromJson(String str) =>
      AllUserData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllUserData.fromMap(Map<String, dynamic> json) => AllUserData(
        address: AllUserAddress.fromMap(json["address"]),
        id: json["id"],
        email: json["email"],
        username: json["username"],
        password: json["password"],
        name: AllUserName.fromMap(json["name"]),
        phone: json["phone"],
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "address": address.toMap(),
        "id": id,
        "email": email,
        "username": username,
        "password": password,
        "name": name.toMap(),
        "phone": phone,
        "__v": v,
      };

  @override
  List<Object?> get props => [
        address,
        id,
        email,
        username,
        password,
        name,
        phone,
        v,
      ];
}

class AllUserAddress extends Equatable {
  AllUserAddress({
    required this.geolocation,
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
  });

  final AllUserGeolocation geolocation;
  final String city;
  final String street;
  final int number;
  final String zipcode;

  factory AllUserAddress.fromJson(String str) =>
      AllUserAddress.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllUserAddress.fromMap(Map<String, dynamic> json) => AllUserAddress(
        geolocation: AllUserGeolocation.fromMap(json["geolocation"]),
        city: json["city"],
        street: json["street"],
        number: json["number"],
        zipcode: json["zipcode"],
      );

  Map<String, dynamic> toMap() => {
        "geolocation": geolocation.toMap(),
        "city": city,
        "street": street,
        "number": number,
        "zipcode": zipcode,
      };

  @override
  List<Object?> get props => [
        geolocation,
        city,
        street,
        number,
        zipcode,
      ];
}

class AllUserGeolocation extends Equatable {
  AllUserGeolocation({
    required this.lat,
    required this.long,
  });

  final String lat;
  final String long;

  factory AllUserGeolocation.fromJson(String str) =>
      AllUserGeolocation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllUserGeolocation.fromMap(Map<String, dynamic> json) =>
      AllUserGeolocation(
        lat: json["lat"],
        long: json["long"],
      );

  Map<String, dynamic> toMap() => {
        "lat": lat,
        "long": long,
      };

  @override
  List<Object?> get props => [lat, long];
}

class AllUserName extends Equatable {
  AllUserName({
    required this.firstname,
    required this.lastname,
  });

  final String firstname;
  final String lastname;

  factory AllUserName.fromJson(String str) =>
      AllUserName.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllUserName.fromMap(Map<String, dynamic> json) => AllUserName(
        firstname: json["firstname"],
        lastname: json["lastname"],
      );

  Map<String, dynamic> toMap() => {
        "firstname": firstname,
        "lastname": lastname,
      };

  @override
  List<Object?> get props => [
        firstname,
        lastname,
      ];
}
