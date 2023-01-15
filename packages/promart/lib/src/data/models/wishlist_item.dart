import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:promart/promart.dart';

part 'wishlist_item.freezed.dart';
part 'wishlist_item.g.dart';

@freezed
class WishlistItem with _$WishlistItem {
  const factory WishlistItem({
    // required bool isWish,
    required AllProductData product,
  }) = _WishlistItem;

  factory WishlistItem.fromJson(Map<String, dynamic> json) =>
      _$WishlistItemFromJson(json);
}
