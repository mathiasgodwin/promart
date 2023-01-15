// ignore_for_file: prefer_const_constructors_in_immutables
// ignore_for_file: prefer_initializing_formals

import 'package:equatable/equatable.dart';

class UserEnity extends Equatable {
  UserEnity({
    String? email,
    String? username,
    String? password,
    String? firstname,
    String? lastname,
    String? city,
    String? street,
    String? number,
    String? lat,
    String? long,
    String? phone,
  })  : email = email!,
        username = username!,
        password = password!,
        firstname = firstname!,
        lastname = lastname!,
        city = city!,
        street = street!,
        number = number!,
        lat = lat!,
        long = long!,
        phone = phone!;
  final String email;
  final String username;
  final String password;
  final String firstname;
  final String lastname;
  final String city;
  final String street;
  final String number;
  final String lat;
  final String long;
  final String phone;

  @override
  List<Object?> get props => [
        email,
        username,
        password,
        firstname,
        lastname,
        city,
        street,
        number,
        lat,
        long,
        phone,
      ];
}
