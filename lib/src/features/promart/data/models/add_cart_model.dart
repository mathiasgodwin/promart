// To parse this JSON data, do
//
//     final singleCartModel = singleCartModelFromMap(jsonString);

// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables

import 'dart:convert';

import 'package:equatable/equatable.dart';

class AddCartModel extends Equatable {
  AddCartModel({
    required this.userId,
    required this.date,
    required this.products,
  });

  final int userId;
  final DateTime date;
  final List<AddCartProduct> products;

  factory AddCartModel.fromJson(String str) =>
      AddCartModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddCartModel.fromMap(Map<String, dynamic> json) => AddCartModel(
        userId: json["userId"],
        date: DateTime.parse(json["date"]),
        products: List<AddCartProduct>.from(
            json["products"].map((x) => AddCartProduct.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "date": date.toIso8601String(),
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
      };

  @override
  List<Object?> get props => [ userId, date, products, ];
}

class AddCartProduct extends Equatable {
  AddCartProduct({
    required this.productId,
    required this.quantity,
  });

  final int productId;
  final int quantity;

  factory AddCartProduct.fromJson(String str) =>
      AddCartProduct.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddCartProduct.fromMap(Map<String, dynamic> json) => AddCartProduct(
        productId: json["productId"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "productId": productId,
        "quantity": quantity,
      };

  @override
  List<Object?> get props => [productId, quantity];
}
