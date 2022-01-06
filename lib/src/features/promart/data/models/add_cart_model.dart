// To parse this JSON data, do
//
//     final singleCartModel = singleCartModelFromMap(jsonString);

import 'dart:convert';

class AddCartModel {
  AddCartModel({
    required this.data,
  });

  final AddCartData data;

  factory AddCartModel.fromJson(String str) =>
      AddCartModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddCartModel.fromMap(Map<String, dynamic> json) => AddCartModel(
        data: AddCartData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data.toMap(),
      };
}

class AddCartData {
  AddCartData({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
    required this.v,
  });

  final int id;
  final int userId;
  final DateTime date;
  final List<AddCartProduct> products;
  final int v;

  factory AddCartData.fromJson(String str) =>
      AddCartData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddCartData.fromMap(Map<String, dynamic> json) => AddCartData(
        id: json["id"],
        userId: json["userId"],
        date: DateTime.parse(json["date"]),
        products: List<AddCartProduct>.from(
            json["products"].map((x) => AddCartProduct.fromMap(x))),
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

class AddCartProduct {
  AddCartProduct({
    required this.productId,
    required this.quantity,
  });

  final int productId;
  final int quantity;

  factory AddCartProduct.fromJson(String str) =>
      AddCartProduct.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddCartProduct.fromMap(Map<String, dynamic> json) =>
      AddCartProduct(
        productId: json["productId"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "productId": productId,
        "quantity": quantity,
      };
}
