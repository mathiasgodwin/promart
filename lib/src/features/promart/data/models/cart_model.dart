import 'package:equatable/equatable.dart';
import 'package:promart/src/features/promart/data/data.dart';
import 'package:promart/src/features/promart/data/models/single_product_model.dart';

class CartModel extends Equatable {
  final List<AllProductData> items;
  const CartModel({this.items = const <AllProductData>[]});

  @override
  List<Object?> get props => [
        items,
      ];

  double get totalPrice =>
      items.fold(0, (previousValue, current) => previousValue + current.price);
}
