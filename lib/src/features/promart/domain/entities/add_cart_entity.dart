import 'dart:convert';

class AddCart {
  AddCart({
    required String userId,
    required String date,
    required List<Map<String, int>> product,
  });

  String? userId;
  String? date;
  List<Map<String, int>>? product;

  factory AddCart.fromJson(String str) {
    return AddCart.fromMap(json.decode(str));
  }

  factory AddCart.fromMap(Map<String, dynamic> json) {
    return AddCart(
      userId: json['userId'],
      date: json['date'],
      product: json['product'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'date': date,
      'product': product,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }
}
