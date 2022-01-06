// To parse this JSON data, do
//
//     final singleCartModel = singleCartModelFromMap(jsonString);

import 'dart:convert';

class DeleteCartModel {
  DeleteCartModel({
    required this.data,
  });

  final DeleteCartData data;

  factory DeleteCartModel.fromJson(String str) =>
      DeleteCartModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeleteCartModel.fromMap(Map<String, dynamic> json) => DeleteCartModel(
        data: DeleteCartData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data.toMap(),
      };
}

class DeleteCartData {
  DeleteCartData({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
    required this.v,
  });

  final int id;
  final int userId;
  final DateTime date;
  final List<DeleteCartProduct> products;
  final int v;

  factory DeleteCartData.fromJson(String str) =>
      DeleteCartData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeleteCartData.fromMap(Map<String, dynamic> json) => DeleteCartData(
        id: json["id"],
        userId: json["userId"],
        date: DateTime.parse(json["date"]),
        products: List<DeleteCartProduct>.from(
            json["products"].map((x) => DeleteCartProduct.fromMap(x))),
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

class DeleteCartProduct {
  DeleteCartProduct({
    required this.productId,
    required this.quantity,
  });

  final int productId;
  final int quantity;

  factory DeleteCartProduct.fromJson(String str) =>
      DeleteCartProduct.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeleteCartProduct.fromMap(Map<String, dynamic> json) =>
      DeleteCartProduct(
        productId: json["productId"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "productId": productId,
        "quantity": quantity,
      };
}
