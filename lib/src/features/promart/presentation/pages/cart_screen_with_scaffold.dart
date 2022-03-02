import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promart/src/features/promart/data/data.dart';
import 'package:promart/src/features/promart/presentation/bloc/bloc.dart';
import 'package:promart/src/features/promart/presentation/widgets/sized_network_image.dart';

class CartScreenScaffold extends StatelessWidget {
  const CartScreenScaffold({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const CartScreenScaffold());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'My Cart',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Icon(Icons.shopping_basket_outlined, color: Colors.black,),
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final cartItems = state.items;

          return cartItems.isNotEmpty
              ? _CartListView(cartItems: cartItems)
              : const Center(child: Text('Your cart is empty'));
        },
      ),
    );
  }
}

class _CartListView extends StatelessWidget {
  const _CartListView({required this.cartItems, Key? key}) : super(key: key);

  final BuiltList<CartItem> cartItems;
  double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + item.count * item.product.price);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          for (final item in cartItems) _CartListItem(item: item),
        ],
      ),
    );
  }
}

class _CartListItem extends StatelessWidget {
  const _CartListItem({required this.item, Key? key}) : super(key: key);

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
              imageWidth: 40.0,
              imageHeight: 40.0,
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
