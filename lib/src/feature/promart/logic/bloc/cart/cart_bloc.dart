import 'package:built_collection/built_collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:promart/src/features/promart/data/data.dart';

part 'cart_event.dart';
part 'cart_state.dart';

part 'cart_bloc.freezed.dart';

class CartBloc extends HydratedBloc<CartEvent, CartState> {
  CartBloc() : super(CartState.initial()) {
    on<ProductAdded>(_onProductAdded);
    on<CartItemRemoved>(_onCartItemRemoved);
    on<CartItemCountIncreased>(_onCartItemCountIncreased);
    on<CartItemCountDecreased>(_onCartItemCountDecreased);
  }

  void _onProductAdded(ProductAdded event, Emitter<CartState> emit) async {
    final cartItem = CartItem(count: 1, product: event.product);
    final cartItemIndex = state.items.indexWhere(
      (item) => item.product == cartItem.product,
    );

    if (cartItemIndex >= 0) {
      // Counter value (+1) for increasing the items if item already in cart list
      int value = 1;
      final items = state.items.rebuild(
        (builder) => builder[cartItemIndex] =
            cartItem.copyWith(count: cartItem.count + value),
      );
      emit(state.copyWith(items: items));
    } else {
      // Or freshly add the item to the list of carts
      final items = state.items.rebuild((builder) => builder.add(cartItem));

      emit(state.copyWith(items: items));
    }
  }

  void _onCartItemRemoved(
      CartItemRemoved event, Emitter<CartState> emit) async {
    final cartItem = event.item;

    // Remove the cart item from the cart list
    final items = state.items.rebuild((builder) => builder.remove(cartItem));

    emit(state.copyWith(items: items));
  }

  void _onCartItemCountIncreased(
      CartItemCountIncreased event, Emitter<CartState> emit) async {
    final cartItem = event.item;
    final cartItemIndex = state.items.indexOf(cartItem);

    if (cartItemIndex >= 0) {
      // Counter value (+1) for increasing the items if item already in cart list
      int value = 1;
      final items = state.items.rebuild(
        (builder) => builder[cartItemIndex] =
            cartItem.copyWith(count: cartItem.count + value),
      );
      emit(state.copyWith(items: items));
    }
  }

  void _onCartItemCountDecreased(
      CartItemCountDecreased event, Emitter<CartState> emit) async {
    final cartItem = event.item;

    if (cartItem.count > 1) {
      final cartItemIndex = state.items.indexOf(cartItem);

      if (cartItemIndex >= 0) {
        // Counter value (-1) for decreasing the items in the cart list
        // if the item count is >= 1
        int value = -1;
        final items = state.items.rebuild(
          (builder) => builder[cartItemIndex] =
              cartItem.copyWith(count: cartItem.count + value),
        );
        emit(state.copyWith(items: items));
      }
    } else {
      // Else remove the item cus it's the last left in the list
      final items = state.items.rebuild((builder) => builder.remove(cartItem));

      emit(state.copyWith(items: items));
    }
  }

// With this we can gaurantee at least our carts will persist across sessions
  @override
  CartState fromJson(Map<String, dynamic> json) {
    final cartItemsJsonList = json['items'] as List;
    final cartItems =
        cartItemsJsonList.map((item) => CartItem.fromJson(item)).toList();

    return CartState(items: cartItems.build());
  }

  @override
  Map<String, dynamic> toJson(CartState state) {
    return <String, dynamic>{
      'items': state.items.toList(),
    };
  }
}
