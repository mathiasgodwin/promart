// To parse this JSON data, do
//
//     final allCategoryModel = allCategoryModelFromMap(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class AllCategoryModel extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  AllCategoryModel({
    required this.data,
  });

  final List<String> data;

  factory AllCategoryModel.fromJson(String str) =>
      AllCategoryModel.fromMap(json.decode(str) as List);

  String toJson() => json.encode(toMap());

  factory AllCategoryModel.fromMap(List list) => AllCategoryModel(
        data: List<String>.from(list.map((x) => x).toList()),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x)),
      };

  @override
  List<Object?> get props => [data];
}
