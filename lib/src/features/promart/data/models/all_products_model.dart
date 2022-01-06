// To parse this JSON data, do
//
//     final allProductModel = allProductModelFromMap(jsonString);

import 'dart:convert';

class AllProductModel {
  AllProductModel({
    required this.data,
  });

  final List<AllProductData> data;

  factory AllProductModel.fromJson(String str) =>
      AllProductModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllProductModel.fromMap(Map<String, dynamic> json) => AllProductModel(
        data: List<AllProductData>.from(json["data"].map((x) => AllProductData.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class AllProductData {
  AllProductData({
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
  final AllProductRating rating;

  factory AllProductData.fromJson(String str) => AllProductData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllProductData.fromMap(Map<String, dynamic> json) => AllProductData(
        id: json["id"],
        title: json["title"],
        price: json["price"].toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
        rating: AllProductRating.fromMap(json["rating"]),
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
}

class AllProductRating {
  AllProductRating({
    required this.rate,
    required this.count,
  });

  final double rate;
  final int count;

  factory AllProductRating.fromJson(String str) => AllProductRating.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllProductRating.fromMap(Map<String, dynamic> json) => AllProductRating(
        rate: json["rate"].toDouble(),
        count: json["count"],
      );

  Map<String, dynamic> toMap() => {
        "rate": rate,
        "count": count,
      };
}
