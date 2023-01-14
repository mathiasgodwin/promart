// To parse this JSON data, do
//
//     final singleProductModel = singleProductModelFromMap(jsonString);

// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:convert';

import 'package:equatable/equatable.dart';

class SingleProductModel extends Equatable {
  SingleProductModel({
    required this.data,
  });

  final SingleProductData data;

  factory SingleProductModel.fromJson(String str) =>
      SingleProductModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SingleProductModel.fromMap(Map<String, dynamic> json) =>
      SingleProductModel(
        data: SingleProductData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data.toMap(),
      };

  @override
  List<Object?> get props => [data];
}

class SingleProductData extends Equatable {
  SingleProductData({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final SingleProductRating rating;

  factory SingleProductData.fromJson(String str) =>
      SingleProductData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SingleProductData.fromMap(Map<String, dynamic> json) =>
      SingleProductData(
        id: json["id"],
        title: json["title"],
        price: json["price"].toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
        rating: SingleProductRating.fromMap(json["rating"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "rating": rating.toMap(),
      };

  @override
  
  List<Object?> get props => [
        id,
        title,
        price,
        description,
        category,
        image,
        rating,
      ];
}

class SingleProductRating extends Equatable {
  SingleProductRating({
    required this.rate,
    required this.count,
  });

  final double rate;
  final int count;

  factory SingleProductRating.fromJson(String str) =>
      SingleProductRating.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SingleProductRating.fromMap(Map<String, dynamic> json) =>
      SingleProductRating(
        rate: json["rate"].toDouble(),
        count: json["count"],
      );

  Map<String, dynamic> toMap() => {
        "rate": rate,
        "count": count,
      };

  @override
  List<Object?> get props => [rate, count];
}
