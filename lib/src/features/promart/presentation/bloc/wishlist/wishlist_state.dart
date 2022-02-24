part of 'wishlist_bloc.dart';


@freezed
class WishlistState with _$WishlistState {

  const factory WishlistState({
    required BuiltList<WishlistItem> items,
  }) = _WishlistState;
  
   factory WishlistState.initial() => WishlistState(items: <WishlistItem>[].build());
}
