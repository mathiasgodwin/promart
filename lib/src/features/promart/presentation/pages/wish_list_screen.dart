import 'package:flutter/material.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({Key? key}) : super(key: key);

  static PreferredSizeWidget  appBar() => AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Wishlist',
          style: TextStyle(fontSize: 20),
        ),
        actions: const [Icon(Icons.favorite)],
      );
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Wish List'),
    );
  }
}
