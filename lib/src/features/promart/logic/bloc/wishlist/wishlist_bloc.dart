import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:promart_api/promart.dart';


part 'wishlist_event.dart';
part 'wishlist_state.dart';
part 'wishlist_bloc.freezed.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistState.initial()) {
    on<WishAdded>(_onWishAdded);
    // on<WishRemoved>(_onWishRemoved);
  }

  void _onWishAdded(WishAdded event, Emitter<WishlistState> emit) {
    final wishItem = WishlistItem(product: event.product);
    final isWished = state.items.contains(wishItem);

    if (isWished) {
      final items = state.items.rebuild((builder) => builder.remove(wishItem));
      emit(state.copyWith(items: items));
    } else {
      final items = state.items.rebuild((builder) => builder.add(wishItem));
      emit(state.copyWith(items: items));
    }
  }

  // void _onWishRemoved(WishRemoved event, Emitter<WishlistState> emit) {
  //   final wishItem = event.item;
  //   final isWished = state.items.contains(wishItem);
  //   if (isWished) {
  //     final items = state.items.rebuild((builder) => builder.remove(wishItem));
  //     emit(state.copyWith(items: items));
  //   } else {}
  // }
}
