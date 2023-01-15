import 'package:flutter/material.dart';

import 'package:built_collection/built_collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promart/src/features/promart/data/models/wishlist_item.dart';
import 'package:promart/src/features/promart/presentation/bloc/bloc.dart';
import 'package:promart/src/features/promart/presentation/widgets/sized_network_image.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const WishlistScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistBloc, WishlistState>(
      builder: (context, state) {
        final wishItems = state.items;
        return wishItems.isNotEmpty
            ? _WishlistListView(wishListItem: wishItems)
            : const Center(
                child: Text('Your Wishlist is empty'),
              );
      },
    );
  }
}

class _WishlistListView extends StatelessWidget {
  final BuiltList<WishlistItem> wishListItem;
  const _WishlistListView({required this.wishListItem, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [for (final item in wishListItem) _WishlistItem(item: item)],
      ),
    );
  }
}

class _WishlistItem extends StatelessWidget {
  const _WishlistItem({required this.item, Key? key}) : super(key: key);

  final WishlistItem item;

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<WishlistBloc>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => bloc.add(WishAdded(product: item.product)),
          ),
          Expanded(
            child: SizedNetworkImage(
              imageUrl: item.product.image,
              imageWidth: 40.0,
              imageHeight: 40.0,
            ),
          ),
        ],
      ),
    );
  }
}
