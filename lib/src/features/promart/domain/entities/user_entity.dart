import 'dart:convert';

class UserEntity {
  UserEntity(
      {String? email,
      String? username,
      String? password,
      String? firstname,
      String? lastname,
      String? city,
      String? street,
      String? number,
      String? lat,
      String? long,
      String? phone});
  String? email;
  String? username;
  String? password;
  String? firstname;
  String? lastname;
  String? city;
  String? street;
  String? number;
  String? lat;
  String? long;
  String? phone;

  factory UserEntity.fromMap(Map<String, dynamic> json) {
    return UserEntity(
      email: json['email'],
      username: json['username'],
      password: json['password'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      city: json['city'],
      street: json['street'],
      number: json['number'],
      lat: json['lat'],
      long: json['long'],
      phone: json['phone'],
    );
  }

  factory UserEntity.fromJson(String str) {
    return UserEntity.fromMap(json.decode(str));
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'password': password,
      'firstname': firstname,
      'lastname': lastname,
      'city': city,
      'street': street,
      'number': number,
      'lat': lat,
      'long': long,
      'phone': phone
    };
  }

  String toJson() {
    return json.encode(toMap());
  }
}
