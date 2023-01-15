import 'package:promart/src/features/promart/data/models/all_products_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item.freezed.dart';
part 'cart_item.g.dart';

@freezed
class CartItem with _$CartItem {
  @Assert('count > 0')
  const factory CartItem(
      {required int count, required AllProductData product}) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
}
