// To parse this JSON data, do
//
//     final singleUserModel = singleUserModelFromMap(jsonString);

import 'dart:convert';

class SingleUserModel {
  SingleUserModel({
    required this.data,
  });

  final SingleUserData data;

  factory SingleUserModel.fromJson(String str) =>
      SingleUserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SingleUserModel.fromMap(Map<String, dynamic> json) => SingleUserModel(
        data: SingleUserData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data.toMap(),
      };
}

class SingleUserData {
  SingleUserData({
    required this.address,
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.phone,
    required this.v,
  });

  final SingleUserAddress address;
  final int id;
  final String email;
  final String username;
  final String password;
  final SingleUserName name;
  final String phone;
  final int v;

  factory SingleUserData.fromJson(String str) => SingleUserData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SingleUserData.fromMap(Map<String, dynamic> json) => SingleUserData(
        address: SingleUserAddress.fromMap(json["address"]),
        id: json["id"],
        email: json["email"],
        username: json["username"],
        password: json["password"],
        name: SingleUserName.fromMap(json["name"]),
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
}

class SingleUserAddress {
  SingleUserAddress({
    required this.geolocation,
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
  });

  final SingleUserGeolocation geolocation;
  final String city;
  final String street;
  final int number;
  final String zipcode;

  factory SingleUserAddress.fromJson(String str) => SingleUserAddress.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SingleUserAddress.fromMap(Map<String, dynamic> json) => SingleUserAddress(
        geolocation: SingleUserGeolocation.fromMap(json["geolocation"]),
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
}

class SingleUserGeolocation {
  SingleUserGeolocation({
    required this.lat,
    required this.long,
  });

  final String lat;
  final String long;

  factory SingleUserGeolocation.fromJson(String str) =>
      SingleUserGeolocation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SingleUserGeolocation.fromMap(Map<String, dynamic> json) => SingleUserGeolocation(
        lat: json["lat"],
        long: json["long"],
      );

  Map<String, dynamic> toMap() => {
        "lat": lat,
        "long": long,
      };
}

class SingleUserName {
  SingleUserName({
    required this.firstname,
    required this.lastname,
  });

  final String firstname;
  final String lastname;

  factory SingleUserName.fromJson(String str) => SingleUserName.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SingleUserName.fromMap(Map<String, dynamic> json) => SingleUserName(
        firstname: json["firstname"],
        lastname: json["lastname"],
      );

  Map<String, dynamic> toMap() => {
        "firstname": firstname,
        "lastname": lastname,
      };
}
