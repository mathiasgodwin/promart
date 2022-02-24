import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promart/src/features/promart/data/data.dart';
import 'package:promart/src/features/promart/presentation/bloc/bloc.dart';
import 'package:promart/src/features/promart/presentation/widgets/sized_network_image.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const CartScreen());
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final cartItems = state.items;

        return cartItems.isNotEmpty
            ? CartListView(cartItems: cartItems)
            : const Center(child: Text('Your cart is empty'));
      },
    );
  }
}



class CartListView extends StatelessWidget {
  const CartListView({required this.cartItems, Key? key}) : super(key: key);

  final BuiltList<CartItem> cartItems;
  double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + item.count * item.product.price);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          for (final item in cartItems) CartListItem(item: item),
        ],
      ),
    );
  }
}

class CartListItem extends StatelessWidget {
  const CartListItem({required this.item, Key? key}) : super(key: key);

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<CartBloc>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => bloc.add(CartItemRemoved(item: item)),
          ),
          Expanded(
            child: SizedNetworkImage(
              imageUrl: item.product.image,
              imageWidth: 20.0,
              imageHeight: 20.0,
            ),
          ),
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => bloc.add(CartItemCountIncreased(item: item)),
              ),
              Text(
                '${item.count}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () => bloc.add(CartItemCountDecreased(item: item)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
