part of 'cart_cubit.dart';

enum CartStatus {
  cartAdded,
  cartRemoved,
  cartLoading,
  cartLoaded,
  cartError,
}

class CartState extends Equatable {
  final CartStatus status;
  final CartModel cart;
  final String errorMessage;

  const CartState({
    this.status = CartStatus.cartLoading,
    this.errorMessage = 'Could not load cart.',
    this.cart = const CartModel(),
    
  });

  @override
  List<Object> get props => [status, cart];

  CartState copyWith({
    CartStatus? status,
    CartModel? cart,
    String? errorMessage,
  }) {
    return CartState(
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      cart: cart ?? this.cart,
    );
  }
}
