// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:promart/promart.dart';

class AddCartEntity extends Equatable {
  AddCartEntity({
    required int userId,
    required DateTime date,
    required List<AddCartProduct> product,
  });

  int? userId;
  DateTime? date;
  List<AddCartProduct>? product;

  @override
  List<Object?> get props => [userId, date, product];
}
