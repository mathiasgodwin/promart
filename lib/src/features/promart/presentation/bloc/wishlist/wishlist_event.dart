part of 'wishlist_bloc.dart';

@freezed
class WishlistEvent with _$WishlistEvent {
  const factory WishlistEvent.added({
    required AllProductData product,
  }) = WishAdded;

  const factory WishlistEvent.removed({
    required WishlistItem item,
  }) = WishRemoved;
}
