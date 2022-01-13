// To parse this JSON data, do
//
//     final allCategoryModel = allCategoryModelFromMap(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class AllCategoryModel extends Equatable {
  AllCategoryModel({
    required this.data,
  });

  final List<String> data;

  factory AllCategoryModel.fromJson(String str) =>
      AllCategoryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllCategoryModel.fromMap(Map<String, dynamic> json) =>
      AllCategoryModel(
        data: List<String>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x)),
      };

  @override
  List<Object?> get props => [data];
}
