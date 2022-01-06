// To parse this JSON data, do
//
//     final singleCartModel = singleCartModelFromMap(jsonString);

import 'dart:convert';

class SingleCartModel {
  SingleCartModel({
    required this.data,
  });

  final SingleCartData data;

  factory SingleCartModel.fromJson(String str) =>
      SingleCartModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SingleCartModel.fromMap(Map<String, dynamic> json) => SingleCartModel(
        data: SingleCartData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data.toMap(),
      };
}

class SingleCartData {
  SingleCartData({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
    required this.v,
  });

  final int id;
  final int userId;
  final DateTime date;
  final List<SingleCartProduct> products;
  final int v;

  factory SingleCartData.fromJson(String str) => SingleCartData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SingleCartData.fromMap(Map<String, dynamic> json) => SingleCartData(
        id: json["id"],
        userId: json["userId"],
        date: DateTime.parse(json["date"]),
        products:
            List<SingleCartProduct>.from(json["products"].map((x) => SingleCartProduct.fromMap(x))),
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

class SingleCartProduct {
  SingleCartProduct({
    required this.productId,
    required this.quantity,
  });

  final int productId;
  final int quantity;

  factory SingleCartProduct.fromJson(String str) => SingleCartProduct.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SingleCartProduct.fromMap(Map<String, dynamic> json) => SingleCartProduct(
        productId: json["productId"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "productId": productId,
        "quantity": quantity,
      };
}
