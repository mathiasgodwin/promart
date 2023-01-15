import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:promart/promart.dart';

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
