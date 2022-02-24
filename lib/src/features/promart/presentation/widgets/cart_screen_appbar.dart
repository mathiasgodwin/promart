import 'package:flutter/material.dart';

class CartScreenAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  CartScreenAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _cartScreenAppBar();
  }

  Widget _cartScreenAppBar() {
    return AppBar(
    backgroundColor: Colors.white,
    title: const Text(
      'My Cart',
      style: TextStyle(fontSize: 20),
    ),
    actions: const [
      Icon(Icons.shopping_basket_outlined),
    ],
  );
  }
}
