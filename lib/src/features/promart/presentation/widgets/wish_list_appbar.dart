import 'package:flutter/material.dart';

class WishListAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  const WishListAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _wishListAppBar();
  }

  Widget _wishListAppBar() {
    return AppBar(
      leadingWidth: 1,
      leading: const SizedBox(),
      elevation: 0.0,
      backgroundColor: Colors.purple,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Promart!',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: kToolbarHeight * 0.4,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: kToolbarHeight * 0.08,
          ),
          Text(
            "Let's go shopping",
            style:
                TextStyle(color: Colors.white, fontSize: kToolbarHeight * 0.2),
          )
        ],
      ),
      actions: <Widget>[
        IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded)),
        IconButton(
            onPressed: () {
              // Navigator.of(context).push(CartScreen.route());
            },
            icon: const Icon(Icons.shopping_basket_rounded))
      ],
    );
  }
}
