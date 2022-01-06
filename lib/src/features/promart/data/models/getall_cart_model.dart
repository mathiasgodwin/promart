// To parse this JSON data, do
//
//     final allCartModel = allCartModelFromMap(jsonString);

import 'dart:convert';

class AllCartModel {
  AllCartModel({
    required this.data,
  });

  final List<AllCartData> data;

  factory AllCartModel.fromJson(String str) =>
      AllCartModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllCartModel.fromMap(Map<String, dynamic> json) => AllCartModel(
        data: List<AllCartData>.from(
            json["data"].map((x) => AllCartData.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class AllCartData {
  AllCartData({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
    required this.v,
  });

  final int id;
  final int userId;
  final DateTime date;
  final List<AllCartProduct> products;
  final int v;

  factory AllCartData.fromJson(String str) =>
      AllCartData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllCartData.fromMap(Map<String, dynamic> json) => AllCartData(
        id: json["id"],
        userId: json["userId"],
        date: DateTime.parse(json["date"]),
        products: List<AllCartProduct>.from(
            json["products"].map((x) => AllCartProduct.fromMap(x))),
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "userId": userId,
        "date": date.toIso8601String(),
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
        "__v": v,
      };
}

class AllCartProduct {
  AllCartProduct({
    required this.productId,
    required this.quantity,
  });

  final int productId;
  final int quantity;

  factory AllCartProduct.fromJson(String str) =>
      AllCartProduct.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllCartProduct.fromMap(Map<String, dynamic> json) => AllCartProduct(
        productId: json["productId"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "productId": productId,
        "quantity": quantity,
      };
}
