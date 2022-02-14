import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:promart/src/features/promart/data/data.dart';
import 'package:promart/src/features/promart/data/models/cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final PromartRepository repository;
  CartCubit({required this.repository}) : super(const CartState());

  void loadCart() async {
    emit(state.copyWith(status: CartStatus.cartLoading));
    try {
      // Just to mimic a getCart
      final items = await repository.getAllProducts(limit: '5');
      emit(state.copyWith(
          status: CartStatus.cartLoaded,
          cart: CartModel(items: [...items!.data])));
    } catch (e) {
      emit(state.copyWith(
          status: CartStatus.cartError,
          errorMessage: 'Could not load carts, try again.'));
    }
  }

  void addCart(List<AddCartProduct> addCartProduct) async {
    emit(state.copyWith(status: CartStatus.cartLoading));
    try {
      final items = repository.addCart(
          carts: AddCartModel(
              date: DateTime.now(), userId: 2, products: [...addCartProduct]));
          
    } catch (e) {}
  }
}
